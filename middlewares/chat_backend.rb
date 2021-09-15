require 'faye/websocket'
require 'thread'
require 'redis'
require 'json'
require 'erb'

$redis = Redis.new( url: ENV['REDIS_URL'] )

module KissMarryKill
  class ChatBackend
    KEEPALIVE_TIME = 3 # in seconds
    CHANNEL        = "chat-demo"

    def initialize(app)
      @app     = app
      @channels = {} #put these in redis?
      
      # @clients = []
      # uri = URI.parse(ENV["REDIS_URL"])
      # $redis = Redis.new(host: uri.host, port: uri.port, password: uri.password)

      # Thread.new do
      #   redis_sub = Redis.new(host: uri.host, port: uri.port, password: uri.password)
      #   redis_sub.subscribe(CHANNEL) do |on|
      #     on.message do |channel, msg|
      #       @clients.each {|ws| ws.send(msg) }
      #     end
      #   end
      # end
    end

    def call(env)
      if Faye::WebSocket.websocket?(env)
        ws = Faye::WebSocket.new(env, nil, {ping: KEEPALIVE_TIME })
        myChannel = env["REQUEST_PATH"].gsub(/\W+/, '')
        ws.on :open do |event|
          p [:open, myChannel, ws.object_id]
          
          # create channel if not already created
          if !@channels.keys.include? myChannel
            @channels[myChannel] = []
            uri = URI.parse(ENV["REDIS_URL"])
            Thread.new do
              redis_sub = Redis.new( url: ENV['REDIS_URL'] ) 
              redis_sub.subscribe(myChannel) do |on|              
                on.message do |channel, msg|
                  @channels[myChannel].each {|ws| ws.send(msg) }
                end
              end
            end
          end

          # add ws to list of channel's ws
          @channels[myChannel] << ws
          message = {type:"ws", data: {message:"#{ws.object_id} opened connection"}}.to_json          
          $redis.publish(myChannel, message)
        end

        ws.on :message do |event|
          myChannel = env["REQUEST_PATH"].gsub(/\W+/, '')
          p [:message, myChannel, event.data]
          $redis.publish(myChannel, sanitize(event.data))
        end

        ws.on :close do |event|
          myChannel = env["REQUEST_PATH"].gsub(/\W+/, '')
          p [:close, myChannel, ws.object_id, event.code, event.reason]
          @channels[myChannel].delete(ws)
          message = {type:"ws", data: {message:"#{ws.object_id} closed connection"}}.to_json
          $redis.publish(myChannel, message)
          ws = nil
        end

        # Return async Rack response
        ws.rack_response

      else
        @app.call(env)
      end
    end

    private
    def sanitize(message)
      json = JSON.parse(message)
      json.each {|key, value| json[key] = ERB::Util.html_escape(value) }
      JSON.generate(json)
    end
  end
end
