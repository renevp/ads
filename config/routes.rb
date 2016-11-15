Rails.application.routes.draw do
  devise_for :users

  resources :advertisements
  resources :users

  root to: 'welcome#index'
end
