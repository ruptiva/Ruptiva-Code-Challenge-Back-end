# frozen_string_literal: true

Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    scope :v1 do
      devise_for :users, skip: :passwords,
                         controllers: { sessions: 'api/v1/sessions' }
    end
  end

  namespace :api do
    namespace :v1 do
      resources :users, only: %i[index show update destroy]
    end
  end
end
