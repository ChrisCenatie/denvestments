Rails.application.routes.draw do
  resources :loans, only: [:index]
  resources :categories, only: [:show]
end
