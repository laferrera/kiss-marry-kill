class Game < ActiveRecord::Base
    before_create :generate_uid
    after_save :broadcast_to_ws

    has_many :users
    belongs_to :question_set
    has_many :questions, :through => :question_set

    enum status: [ :created, :started, :in_round, :end_round, :ended]

    # def as_json(option)
    #     super(:only => [:name, :id, :game_id])
    # end

    def generate_uid
        self.uid = SecureRandom.hex(2)
    end

    def broadcast_to_ws
        message = {type:"game_update", data: {game: self}}.to_json
        $redis.publish(self.uid, message)
    end

    def current_round_responses
        question = self.questions[self.current_round]
        self.question_responses(question)
    end

    def question_responses(question)
        responses = []
        self.users.each do |user|
            key = "round-answer-g#{self.id}-q#{question.id}-u#{user.id}"
            r = Round.load_from_redis(key)
            responses << r unless r.nil?
        end
        responses
    end

    def broadcast_round_summary_to_ws(mode)
        responses = self.current_round_responses
        option1 = []
        option2 = []
        option3 = []
        responses.each do |r|
            # eval("kisses") get us kisees[], so could be even more clever if we wanted
            option1 << r.user if r.instance_variable_get(:@option1) == mode
            option2 << r.user if r.instance_variable_get(:@option2) == mode
            option3 << r.user if r.instance_variable_get(:@option3) == mode
        end
        summary = {option1: option1, option2: option2, option3: option3 }
        message = {type:"summary", data: {summary: summary, mode: mode}}.to_json
        $redis.publish(self.uid, message)
    end

end