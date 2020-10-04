# frozen_string_literal: true

module Stats
  class Dispatcher
    prepend BaseService
    attr_reader :short_url, :operation

    def initialize(short_url, operation)
      @short_url = short_url
      @operation = operation
    end

    def call
      use_case = store_service.call(short_url, operation.to_sym)
      return fail!(use_case.error_message) unless use_case.success?

      use_case.result
    end

    private

    def store_service
      case Rails.configuration.store_service&.to_sym
      when :db
        Stats::Store::DbStore
      when :redis
        Stats::Store::RedisStore
      else
        Stats::Store::DbStore
      end
    end
  end
end
