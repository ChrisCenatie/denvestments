Rails.application.routes.draw do
  root to: "welcome#index"
  resources :loans, only: [:index, :show]
  resources :categories, only: [:show]
  post "/cart_items", to: "cart_items#create"
  get "/cart", to: "cart_items#index"
  put "/cart_items/:id", to: "cart_items#update"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/dashboard", to: "users#show"
  delete "/logout", to: "sessions#destroy"
  get "/register", to: "users#new"
  post "/register", to: "users#create"
  delete "/cart_items/:id", to: "cart_items#destroy"
  namespace :admin do
    resources :loans, only: [:index, :new, :create, :edit, :update]
    get "/dashboard", to: "admins#show"
    get "/edit", to: "admins#edit"
    put "/edit", to: "admins#update"
  end
end
