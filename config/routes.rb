# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :recipes, only: [:index, :show, :new, :create]

  resources :foods, only: [:index, :new, :create, :destroy]

  authenticated :user do
    root 'recipes#index', as: :authenticated_root
  end

  unauthenticated :user do
    root 'recipes#public_recipes', as: :unauthenticated_root
  end

end
