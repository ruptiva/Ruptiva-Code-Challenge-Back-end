# frozen_string_literal: true

Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    scope :v1 do
      devise_for :users, skip: :passwords
    end
  end

  namespace :api do
    namespace :v1 do
      resources :users, only: %i[index show destroy]
    end
  end
end
