# frozen_string_literal: true

class ShortUrl < ApplicationRecord
  validates :original_url, :short_url, presence: true
  validates :original_url, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])
end
