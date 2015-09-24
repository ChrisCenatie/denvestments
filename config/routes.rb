Rails.application.routes.draw do
  root to: "welcome#index"
  resources :loans, only: [:index]
  resources :categories, only: [:show]
end
