Rails.application.routes.draw do
  get 'login' => "sessions#new"
  resources :sessions, only: [:new, :create]

  delete 'logout' => 'sessions#destroy'
  resources :users
  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
