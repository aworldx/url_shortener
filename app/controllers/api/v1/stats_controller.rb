# frozen_string_literal: true

module Api
  module V1
    class StatsController < ApplicationController
      def index
        use_case = Stats::Dispatcher.call(params[:url_short_url], :clicks_count)
        response_by_use_case(use_case)
      end
    end
  end
end
