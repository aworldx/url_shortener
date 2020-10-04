# frozen_string_literal: true

module Stats
  module Store
    class BaseStore
      prepend BaseService
      attr_reader :short_url, :operation

      def initialize(short_url, operation)
        @short_url = short_url
        @operation = operation
      end

      def call
        return fail!('short url not found') unless url

        send(operation)
      end

      private

      def original_url
        increment_clicks_counter
      end

      def increment_clicks_counter
        raise 'method not implemented'
      end

      def url
        raise 'method not implemented'
      end

      def clicks_count
        raise 'method not implemented'
      end
    end
  end
end
