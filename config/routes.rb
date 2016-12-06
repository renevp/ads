Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }

  resources :advertisements
  resources :users do
    member do
      patch 'activate'
    end
    resources :messages
  end


  root to: 'welcome#index'
end
