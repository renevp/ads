Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions',
             omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :advertisements do
    resources :messages, except: [:edit, :update]
  end

  resources :users do
    member do
      patch 'activate'
      # get 'messages'
      get 'username'
    end
  end

  root to: 'welcome#index'
end
