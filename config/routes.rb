# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      devise_for :users, skip: :passwords
      resources :users, only: %i[index show destroy]
    end
  end
end
