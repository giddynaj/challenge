require 'yaml'
config = YAML::load(File.open("#{Rails.root}/config/redis.yml"))[Rails.env]
RedisConnection = Redis.new(:host => config['host'], :port => config['port'])
