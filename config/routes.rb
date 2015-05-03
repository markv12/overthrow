Rails.application.routes.draw do
  root 'front_page#index'

  get '/me', to: 'users#show'
  get '/user_graph', to:'users#graph', as: 'user_graph'
  get '/users/new', to: 'users#new', as: 'new_user'
  post '/users', to: 'users#create'

  get '/game', to: 'game#events'

  resources :user_sessions
  get '/logout', to: 'user_sessions#destroy', as: 'destroy_user_session'
end
