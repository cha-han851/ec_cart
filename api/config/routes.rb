# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, format: :json do
    namespace :v1 do
      mount_devise_token_auth_for 'Account', at: 'auth', controllers: {
        registrations: 'api/v1/auth/registrations',
        sessions: 'api/v1/auth/sessions'
      }
      resources :accounts, only: [:index, :show, :destroy]
      resources :products, only: [:index, :show, :create, :destroy]
      resources :categories, only: [:index, :show, :create, :destroy]
      resources :purchase_histories, only: [:index, :show, :destroy]
      # resources :purchase_products
      resources :deliveries, only: [:index, :show, :create, :destroy]
      resources :purchases, only: [:index, :show, :create, :destroy]
    end
  end
end
