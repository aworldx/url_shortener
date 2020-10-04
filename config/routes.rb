# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'health#index'

  namespace :api do
    namespace :v1 do
      resources :urls, only: %i[show create], param: :short_url do
        resources :stats, only: :index
        # get ":short_url/stats", to: "stats#show", on: :collection
      end
    end
  end
end
