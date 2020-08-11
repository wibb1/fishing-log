Rails.application.routes.draw do
  root 'pages#home'
  devise_for :users
  
  get '/trips', to: "trips#index"
 
  get '/trips/:id', to: "trips#index"

  get '/trips/react/new', "trips#index"

  resources :trips, only: [:new, :create, :destroy, :edit, :update]

  namespace :api do
    namespace :v1 do
      resources :trips, only: [:index, :new, :create]
    end
  end
end
