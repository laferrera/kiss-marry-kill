class Round 
    include ActiveModel::Model
    attr_accessor :game_id, :question_id, :user_id, :option1, :option2, :option3


    # json = {"option1"=>"marry", "option2"=>"marry", "option3"=>"marry", "question_id"=>5, "user_id"=>2, "game_id"=>1} 
    def game
        Game.find self.game_id
    end

    def user
        User.find self.user_id
    end

    def question
        Question.find self.question_id
    end


    # key = game_id-question_id-user_id
    #   t.references :game
    #   t.references :question
    #   t.references :user
    #   t.integer :kiss
    #   t.integer :marry
    #   t.integer :kill
    #   t.timestamps

    def save_and_broadcast_and_check_to_end_round
        self.save_to_redis
        self.broadcast_to_ws
        self.add_to_user_ids_of_round
        if self.all_users_submitted_this_round? 
            p "ending round for question: #{self.question_id}"
            self.end_game_round
        end
    end

    def redis_key
        "round-answer-g#{self.game_id}-q#{self.question_id}-u#{self.user_id}"
    end

    def save_to_redis
        $redis.set(self.redis_key, self.to_json)
    end

    def redis_round_key
        "round_user_ids-g#{self.game_id}-q#{self.question_id}"
    end

    def add_to_user_ids_of_round
        $redis.lpush(self.redis_round_key, self.user_id)
    end

    def all_users_submitted_this_round? 
        user_ids = self.game.users.select(:id).map {|i| i.id}
        redis_user_ids = $redis.lrange(self.redis_round_key,0, -1).map {|i| i.to_i}.uniq
        user_ids - redis_user_ids == []
    end

    def end_game_round
        game = self.game
        game.status = "end_round"
        game.save
    end

    def check_responses_and_autoend_round
    end

    def self.load_from_redis(redis_key)
        redis_response = $redis.get(redis_key)
        if redis_response
            json = JSON.parse(redis_response)
            Round.new(json)
        else
            nil
        end
    end
   
    def broadcast_to_ws
        message = {type:"round_update", data: {round:self}}.to_json
        $redis.publish(self.game.uid, message)
    end

end