Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations', sessions: 'sessions' }

  authenticated :user do
    root 'recipes#index', as: :authenticated_root
  end

  devise_scope :user do
    root 'devise/registrations#new'
  end

  resource :user, only: [:edit, :update]

  resources :recipes do
    collection do
      get :im_feeling_lucky
      resources :friends, only: :index, module: :recipes, as: :friends_recipes
    end

    member do
      resource :notes, only: [:edit], module: 'recipes', as: 'recipe_notes'
      resource :image, only: [:destroy], module: 'recipes', as: 'recipe_image'
      resource :likes, only: [:create, :destroy], module: 'recipes', as: 'recipe_likes'
    end
  end

  resources :friendships, except: [:show], path: 'friends', param: :uuid do
    member do
      get :accept
    end
  end
end
