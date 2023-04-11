Rails.application.routes.draw do
  root 'application#hello'

  get 'goodbye', to: 'application#goodbye'
  get 'extra', to: 'application#extra'

end
