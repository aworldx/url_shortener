# frozen_string_literal: true

module Urls
  module Store
    class DbStore
      prepend BaseService
      attr_reader :short_url, :original_url

      def initialize(original_url, short_url)
        @short_url = short_url
        @original_url = original_url
      end

      def call
        url = ShortUrl.create(original_url: original_url, short_url: short_url)
        fail!(url.errors.full_messages) unless url.persisted?
      rescue ActiveRecord::RecordNotUnique
        fail!('not uniq short url')
      end
    end
  end
end
