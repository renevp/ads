Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }

  resources :advertisements do
    resources :messages, except: [:edit, :update]
  end

  resources :users do
    member do
      patch 'activate'
      # get 'messages'
    end
  end

  root to: 'welcome#index'
end
