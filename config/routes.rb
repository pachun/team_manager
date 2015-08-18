Rails.application.routes.draw do
  resources :teams, only: [:index, :show, :create, :update]
end
