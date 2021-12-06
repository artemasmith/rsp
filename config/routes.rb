Rails.application.routes.draw do
  resources :games, only: [:index, :create]
  root to: 'games#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
