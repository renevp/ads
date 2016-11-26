Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }

  resources :advertisements
  resources :users


  root to: 'welcome#index'
end
