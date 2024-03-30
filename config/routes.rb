Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get "/api/users", to: "api/users#index"
  get "/api/users/:user_id", to: "api/users#show"
  get "/users/:user_id", to: "users#show"

  post "/api/users", to: "api/users#create"
  post "/api/users/auth", to: "api/users#authorize"

  patch "/api/users/:user_id", to: "api/users#update"

  delete "/api/users/:user_id", to: "api/users#destroy"
  # Defines the root path route ("/")
  root "landings#show"
end
