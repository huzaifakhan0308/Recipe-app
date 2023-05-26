Rails.application.routes.draw do
  devise_for :users

  resources :foods, only: [:index, :show, :new, :create, :destroy]

  resources :recipes, only: [:index, :show, :new, :create] do
    resources :recipe_foods, only: [:new, :create, :destroy,]
  end
  get '/general_shopping_lists', to: 'recipe_foods#general_shopping_lists'



  authenticated :user do
    root 'recipes#index', as: :authenticated_root
  end

  unauthenticated :user do
    root 'recipes#public_recipes', as: :unauthenticated_root
  end

end
