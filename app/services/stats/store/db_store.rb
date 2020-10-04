# frozen_string_literal: true

module Stats
  module Store
    class DbStore < Stats::Store::BaseStore
      private

      def original_url
        super
        url.original_url
      end

      def clicks_count
        url.clicks_count
      end

      def url
        @url ||= ShortUrl.find_by(short_url: short_url)
      end

      def increment_clicks_counter
        url.update_column(:clicks_count, url.clicks_count + 1)
      end
    end
  end
end
