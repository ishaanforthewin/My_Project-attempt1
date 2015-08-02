Rails.application.routes.draw do
  resources :runners
  get '/landing' => 'application#something'
  get '/app' => 'application#app'
end
