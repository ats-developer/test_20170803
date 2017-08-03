Rails.application.routes.draw do
  devise_for :users, controllers: {
      registrations: 'users/registrations'
  }
  resources :secret_codes, only: [:index, :create, :destroy]
  root 'home#index'
end
