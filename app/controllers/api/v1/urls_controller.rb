# frozen_string_literal: true

module Api
  module V1
    class UrlsController < ApplicationController
      include ResponseByUseCase

      def show
        use_case = Stats::Dispatcher.call(params[:short_url], :original_url)
        response_by_use_case(use_case)
      end

      def create
        use_case = Urls::Creator.call(params[:url])
        response_by_use_case(use_case)
      end
    end
  end
end
