Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions',
             omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :advertisements do
    resources :messages, except: [:edit, :update]
  end

  resources :users do
    member do
      patch 'activate'
      get 'username'
    end
  end

  resources :favorites, only: [:create, :destroy, :index]

  root to: 'welcome#index'
end
