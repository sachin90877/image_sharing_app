Rails.application.routes.draw do
  resources :profiles
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: "home#index"
  resources :albums
end
