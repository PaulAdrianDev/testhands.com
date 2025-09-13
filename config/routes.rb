Rails.application.routes.draw do
  resource :session, only: %i[ create destroy ]
  resources :passwords, param: :token
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "homepage#index"
  resources :users, only: %i[ create edit update show destroy ] do
    resources :decks, controller: 'users/decks'
  end

  get "signup", to: "users#new"
  get "login", to: "users#login"

  namespace :api do
    namespace :v1 do
      resources :decks do
        get :random, on: :collection
        get :specific_board, on: :collection
      end
    end
  end
end
