Rails.application.routes.draw do
  root 'home#index'
  devise_for :users
  resources :listings
  resources :profiles
  get '/purchases/success', to: 'purchases#success'
  post '/purchases/webhook', to: 'purchases#webhook'
end
