Rails.application.routes.draw do
    # Routes for the Article resource:
  # CREATE
  get '/new_user' => 'users#new'
  post '/users' => 'users#create'

  # READ
  get '/users' => 'users#index'
  get '/users/:id' => 'users#show'

  # UPDATE
  get '/users/:id/edit' => 'users#edit'
  get '/users/:id/update' => 'users#update'

  # DELETE
  get '/users/:id/destroy' => 'users#destroy'
  
  
  get '/landing' => 'application#landing'
  get '/app' => 'application#app'
  root to: 'application#app'
 
  resources :sessions
end
