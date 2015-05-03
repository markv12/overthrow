Rails.application.routes.draw do
  root 'front_page#index'

  get '/me', to: 'users#show'
  get '/user_graph', to:'users#graph', as: 'user_graph'
  get '/users/new', to: 'users#new', as: 'new_user'
  post '/users', to: 'users#create'

  get '/game_events/:id', to: 'game#events'
  get '/game/:id', to: 'game#show', as: 'show_game'
  get '/game/:id/join/', to: 'game#join', as: 'join_game'

  resources :user_sessions
  get '/logout', to: 'user_sessions#destroy', as: 'destroy_user_session'
end
