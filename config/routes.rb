class JsonConstraint
  def matches?(request)
    request.format.json?
  end
end

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations', sessions: 'sessions' }

  authenticated :user do
    root 'recipes#index', as: :authenticated_root
  end

  devise_scope :user do
    root 'devise/registrations#new'
  end

  resource :user, only: [:edit, :update] do
    collection do
      get :check_username
    end
  end

  resource :profile, only: [:edit, :update]

  resources :recipes do
    collection do
      get :im_feeling_lucky
      resources :friends, only: :index, module: :recipes, as: :friends_recipes do
        get :im_feeling_lucky, on: :collection
      end
      resources :favourites, only: :index, module: :recipes, as: :favourite_recipes do
        get :im_feeling_lucky, on: :collection
      end
    end

    member do
      resource :notes, only: [:edit], module: 'recipes', as: 'recipe_notes'
      resource :image, only: [:update, :destroy], module: 'recipes', as: 'recipe_image'
      resource :likes, only: [:create, :destroy], module: 'recipes', as: 'recipe_likes'
      resources :comments, only: [:create, :destroy], module: 'recipes', shallow: true
    end
  end

  resources :invitations, only: [:new, :create], param: :uuid do
    member do
      get :accept
    end
  end

  resources :friendships, only: [:index, :destroy, :create], path: 'friends', param: :uuid do
    member do
      post :accept
    end
  end

  resources :users, only: [], param: :username do
    resources :recipes, only: :index, module: :users do
      get :im_feeling_lucky, on: :collection
    end
  end

  get :find_images, to: 'find_images#index'
end
