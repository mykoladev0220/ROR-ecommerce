# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root 'items#index'

  resources :items, only: %i[index show]

  resources :cart_items, only: %i[create update destroy]

  resource :cart, only: %i[show update] do
    get 'checkout', to: 'checkout#new'
    post 'checkout', to: 'checkout#create'
  end

  resources :bought_items, only: [:index]
end
