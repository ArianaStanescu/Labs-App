Rails.application.routes.draw do
  resources :addresses
  resources :orders
  resources :credit_cards
  resources :categories
  resources :products

  get 'users/index'
  # devise_for :users

  devise_for :users, controllers: { registrations: 'user/registrations' }

  # root 'application#hello'
  # root 'home#new'
  root 'home#index'

  get 'goodbye', to: 'application#goodbye'
  get 'extra', to: 'application#extra'
  get 'newroute', to: 'application#newroute'
  get 'newroute.json', to: 'application#newroute'

  get 'home', to:'home#index'
  # get "sign_up", to: 'users#new'
  get "log_out", to: 'extra#new'
  get 'accounts', to: 'users#index', as: "users"

  # get "edit", to: 'users#new'

  get 'all_products', to: 'home#all_products', as:"all_products"
  # get 'my_account', to: 'home#my_account', as:"my_account"
  get 'my_account', to: 'users#show'

  resources :users do
    resources :credit_cards
    resources :addresses
    resources :orders
  end



end
