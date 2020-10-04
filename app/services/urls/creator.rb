# frozen_string_literal: true

module Urls
  class Creator
    prepend BaseService
    attr_reader :url

    def initialize(url)
      @url = url
    end

    def call
      use_case = Urls::Sanitizer.call(url)
      return fail!(use_case.error_message) unless use_case.success?

      sanitized_url = use_case.result

      use_case = Urls::Encryptor.call(sanitized_url)
      return fail!(use_case.error_message) unless use_case.success?

      short_url_hash = use_case.result

      use_case = store_service.call(sanitized_url, short_url_hash)
      return fail!(use_case.error_message) unless use_case.success?

      "#{Rails.configuration.base_url}/#{short_url_hash}"
    end

    private

    def store_service
      case Rails.configuration.store_service&.to_sym
      when :db
        Urls::Store::DbStore
      when :redis
        Urls::Store::RedisStore
      else
        Urls::Store::DbStore
      end
    end
  end
end
