Rails.application.routes.draw do
  root to: "welcome#index"
  resources :loans, only: [:index]
  resources :categories, only: [:show]
  post "/cart_items", to: "cart_items#create"
  get "/cart", to: "cart_items#index"
  put "/cart_items/:id", to: "cart_items#update"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/dashboard", to: "users#show"
end
