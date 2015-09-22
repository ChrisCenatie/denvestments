Rails.application.routes.draw do
  resources :loans, only: [:index]
end
