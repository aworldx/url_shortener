# frozen_string_literal: true

module Stats
  class PersistWorker < BaseWorker
    sidekiq_options queue: :stats, retry: 1

    def perform
      # TODO: active import
      # https://blog.saeloun.com/2019/11/26/rails-6-insert-all.html

      RedisService.uniq_collection_items('uniq_urls').each do |short_url|
        url = ShortUrl.find_by(short_url: short_url)
        next unless url

        clicks_count = RedisService.read("#{short_url}_counter")
        next if url.clicks_count == clicks_count

        url.update_column(:clicks_count, clicks_count)
      end
    end
  end
end
