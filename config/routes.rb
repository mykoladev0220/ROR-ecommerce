# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root 'items#index'

  resources :items, only: [:index, :show]

  resources :cart_items, only: [:create, :update, :destroy]

  resource :cart, only: [:show, :update] do
    post :checkout
  end

  resources :bought_items, only: [:index]
end
