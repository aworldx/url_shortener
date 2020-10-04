# frozen_string_literal: true

require 'singleton'

class RedisService
  class << self
    def increment(key)
      redis.incr(key)
    end

    def add_to_uniq_collection(key, val)
      redis.sadd(key, val)
    end

    def uniq_collection_items(key)
      redis.smembers(key)
    end

    def write(key, val)
      redis.set(key, val)
    end

    def read(key)
      redis.get(key)
    end

    def redis
      @redis ||= Rails.env.test? ? MockRedis.new : Redis.new(url: Rails.configuration.redis_url)
    end
  end
end
