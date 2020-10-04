# frozen_string_literal: true

class HealthController < ApplicationController
  def index
    render plain: 'OK'
  end
end
