require './app'
require './middlewares/chat_backend'
# require 'redis'
# $redis = Redis.new( url: ENV['REDIS_URL'] ) 

use KissMarryKill::ChatBackend
run KissMarryKill::App
