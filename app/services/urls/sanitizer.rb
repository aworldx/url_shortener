# frozen_string_literal: true

module Urls
  class Sanitizer
    prepend BaseService

    attr_reader :url

    def initialize(url)
      @url = url
    end

    def call
      sanitized_url = url.strip.downcase.gsub(%r{(https?://)|(www\.)}, '')
      "http://#{sanitized_url}"
    end
  end
end
