Rails.application.routes.draw do
  root 'listings#index'
  devise_for :users
  resources :listings
end
