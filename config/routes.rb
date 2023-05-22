# frozen_string_literal: true

Rails.application.routes.draw do
  root 'users#index'

  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
