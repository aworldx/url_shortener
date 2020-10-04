# frozen_string_literal: true

module Urls
  class Encryptor
    prepend BaseService
    attr_reader :url

    def initialize(url)
      @url = url || ''
    end

    def call
      return fail!('empty url') if url.blank?

      Digest::SHA1.hexdigest(url)[8..16]
    end
  end
end
