Rails.application.routes.draw do
  devise_for :users

  root 'application#hello'

  get 'goodbye', to: 'application#goodbye'
  get 'extra', to: 'application#extra'
  get 'newroute', to: 'application#newroute'
  get 'newroute.json', to: 'application#newroute'
  get "sign_up", to: 'users#new'
  get "log_out", to: 'extra#new'
end
