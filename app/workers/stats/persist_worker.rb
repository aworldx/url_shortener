# frozen_string_literal: true

module Stats
  class PersistWorker < BaseWorker
    sidekiq_options queue: :stats, retry: 1

    def perform
      all_short_urls = RedisService.uniq_collection_items('uniq_urls')
      stats = all_short_urls.map do |short_url|
        {
          short_url: short_url,
          clicks_count: RedisService.read("#{short_url}_counter").to_i,
          updated_at: Time.current,
          created_at: Time.current
        }
      end

      ShortUrl.upsert_all(stats, unique_by: :short_url)
    end
  end
end
