Rails.application.routes.draw do
  root 'pages#home'
  devise_for :users
  
  get '/trips', to: "trips#index"
  get '/trips/:id', to: "trips#index"

  namespace :api do
    namespace :v1 do
      resources :trips, only: [:index, :show] 
    end
  end
end
