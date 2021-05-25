Rails.application.routes.draw do
  root 'home#index'
  devise_for :users
  resources :listings
  get '/purchases/success', to: 'purchases#success'
  post '/purchases/webhook', to: 'purchases#webhook'
end
