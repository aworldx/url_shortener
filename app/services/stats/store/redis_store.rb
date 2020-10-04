# frozen_string_literal: true

module Stats
  module Store
    class RedisStore < Stats::Store::BaseStore
      private

      def original_url
        super
        RedisService.read(short_url)
      end

      def clicks_count
        RedisService.read(counter_key).to_i
      end

      def url
        @url ||= RedisService.read(short_url)
      end

      def increment_clicks_counter
        RedisService.increment(counter_key)
      end

      def counter_key
        "#{short_url}_counter"
      end
    end
  end
end
