Rails.application.routes.draw do
  root 'pages#home'
  devise_for :users
  
  get '/trips', to: "trips#index"

  resources :trips, only: [:new, :create]

  namespace :api do
    namespace :v1 do
      resources :trips, only: [:index] 
    end
  end
end
