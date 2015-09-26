Rails.application.routes.draw do
  resources :records
  resources :users
  root 'records#index'
end
