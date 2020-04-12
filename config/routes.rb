Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations', sessions: 'sessions' }

  authenticated :user do
    root 'recipes#index', as: :authenticated_root
  end

  devise_scope :user do
    root 'devise/sessions#new'
  end

  resource :user, only: [:edit, :update]

  resources :recipes do
    collection do
      get :im_feeling_lucky
    end

    member do
      resource :notes, only: [:edit], module: 'recipes'
    end
  end
end
