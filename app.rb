require 'sinatra/base'
require 'pry'
require 'sinatra/activerecord'
require 'redis'
require 'awesome_print'
require 'httparty'
require 'sinatra/reloader'
Dir["models/*.rb"].each {|file| require_relative file }

$redis = Redis.new( url: ENV['REDIS_URL'] )

module KissMarryKill
  class App < Sinatra::Base

    set :static_cache_control, [:public, max_age: 60]


    configure :development do
      register Sinatra::Reloader
    end

    get "/" do
      erb :"index.html"
      # erb :"index.html", :layout => :post #lets do a layout
    end
    
    get "/cache_buster" do
      HTTParty.delete("https://api.cloudflare.com/client/v4/zones/#{ENV['CLOUDFLARE_ZONE']}/purge_cache", { 
        :headers => {"X-Auth-Email" => ENV["CLOUDFLARE_EMAIL"], "X-Auth-Key" => ENV['CLOUDFLARE_KEY'], "Content-Type" => "application/json"},
        :body => '{"purge_everything":true}'
      })    
      "done busted"
    end

    get "/host" do
      @host = true;
      erb :"index.html"
    end

    get "/:channel" do
      @channel = params[:channel]
      erb :"index.html"
    end

    post "/games" do
      json = JSON.parse(request.body.read)
      @game = Game.create(name:json["game"]["name"])
      {game: @game}.to_json   
    end

    get "/games/:uid" do
      @game = Game.find_by_uid(params[:uid])
      if @game
        {game: @game}.merge(questions:@game.questions).to_json   
      else
        {}.to_json
      end
    end

    post "/games/:uid" do
      @game = Game.find_by_uid(params[:uid])
      json = JSON.parse(request.body.read)
      @game.update(json["game"])
      {game: @game}.to_json   
    end

    post "/games/:uid/join" do
      @game = Game.find_by_uid(params[:uid])
      json = JSON.parse(request.body.read)
      @user = User.create({name:json["name"], game_id:@game.id})
      message = {type:"user_joined", data: {user:@user}}.to_json
      $redis.publish(@game.uid, message)
      {user: @user}.to_json   
    end

    get "/games/:uid/players" do
      @game = Game.find_by_uid(params[:uid])
      {users: @game.users}.to_json
    end

    post "/games/:uid/round" do
      @game = Game.find_by_uid(params[:uid])
      json = JSON.parse(request.body.read)
      round = Round.new(json)
      round.save_and_broadcast_and_check_to_end_round
      {round: round}.to_json
      # do stuff
    end

    post "/games/:uid/end_round" do
      @game = Game.find_by_uid(params[:uid])
      json = JSON.parse(request.body.read)
      if @game
        @game.status = "end_round"
        @game.save
      end
      {game: @game,}.to_json   
    end

    post "/games/:uid/start_round" do
      @game = Game.find_by_uid(params[:uid])
      json = JSON.parse(request.body.read)
      if @game
        @game.current_round = @game.current_round + 1 unless (@game.status == "created" || @game.status == "in_round")
        @game.status = "in_round"
        @game.status = "ended" if @game.current_round == @game.question_set.questions.count
        @game.save!
      end
      {game: @game}.to_json   
    end

    post "/games/:uid/show_round_summary" do
      @game = Game.find_by_uid(params[:uid])
      json = JSON.parse(request.body.read)
      mode = json["mode"]
      if @game
        @game.broadcast_round_summary_to_ws(mode)
      end 
    end

    get "/assets/js/application.js" do
      content_type :js
      @scheme = ENV['RACK_ENV'] == "production" ? "wss://" : "ws://"
      erb :"application.js"
    end

  end
end
