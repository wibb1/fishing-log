Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users
  
  get '/homes', to: "homes#index"

  namespace :api do
    namespace :v1 do
      resources :trips, only: [:index] 
    end
  end
end
