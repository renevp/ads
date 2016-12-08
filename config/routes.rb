Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }

  resources :advertisements
  resources :users do
    member do
      patch 'activate'
    end
    resources :messages, except: [:edit, :update]
  end


  root to: 'welcome#index'
end
