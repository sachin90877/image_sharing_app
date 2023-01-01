Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: "home#index"
  resources :albums do 
    resources :photos, :except => [ :delete ]
  end
  delete '/albums/:album_id/photos/:id', to: 'photos#destroy', as: 'delete_album_photo'
  resources :profiles

  get '*all', to: 'application#check_bad_routes', constraints: lambda { |req|
    req.path.exclude? 'rails/active_storage'
  }

end
