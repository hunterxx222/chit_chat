Rails.application.routes.draw do
  resources :friendships

  get 'messages/incoming'

  resources :users do
    resources :messages
  end

  resources :messages do
    get 'incoming' => 'messages'
      collection do
        get 'incoming'
      end

    member do
      post 'mark_as_read'
    end

    collection do
      get :sent
      get :received
    end
  end

  get 'login' => "sessions#new"
  resources :sessions, only: [:new, :create]

  delete 'logout' => 'sessions#destroy'
  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
