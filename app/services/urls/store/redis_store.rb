# frozen_string_literal: true

module Urls
  module Store
    class RedisStore
      prepend BaseService
      attr_reader :short_url, :original_url

      def initialize(original_url, short_url)
        @short_url = short_url || ''
        @original_url = original_url || ''
      end

      def call
        return fail!('empty url') if short_url.blank? || original_url.blank?
        return fail!('not uniq short url') if RedisService.read(short_url)

        RedisService.write(short_url, original_url)
        RedisService.add_to_uniq_collection('uniq_urls', short_url)
      end
    end
  end
end
