Rails.application.routes.draw do
  root 'pages#home'
  devise_for :users
  
  get '/trips/react', to: "trips#index"
  get '/trips/react/:id', to: "trips#index" 
  #get '/trips/react/new', "trips#index"
  post '/trips/react/search', to: 'trips#search'

  resources :trips, only: [:new, :create, :destroy, :edit, :update]

  

  namespace :api do
    namespace :v1 do
      resources :trips, only: [:index, :show]
    end
  end
end
