# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :foods, only: [:index, :show, :create, :destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
    authenticated :user do
      root 'foods#show', as: :authenticated_root
    end

    unauthenticated do
      root 'recipes#public_recipes', as: :unauthenticated_root
    end
  # Defines the root path route ("/")
end
