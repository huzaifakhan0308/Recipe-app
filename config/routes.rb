# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  
  root 'foods#show'

  resources :foods, only: [:index, :show, :create, :destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
