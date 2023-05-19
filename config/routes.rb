Rails.application.routes.draw do
  resources :categories
  resources :products
  get 'users2/index'
  devise_for :users

  # root 'application#hello'
  # root 'home#new'
  root 'home#index'

  get 'goodbye', to: 'application#goodbye'
  get 'extra', to: 'application#extra'
  get 'newroute', to: 'application#newroute'
  get 'newroute.json', to: 'application#newroute'

  get 'home', to:'home#index'
  get "sign_up", to: 'users#new'
  get "log_out", to: 'extra#new'
  get 'users', to: 'users2#index', as: "users"
  get 'all_products', to: 'home#all_products', as:"all_products"


end
