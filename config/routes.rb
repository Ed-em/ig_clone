Rails.application.routes.draw do
  root 'users#new'
  resources :sessions, only: [:new, :create, :destroy]
  resources :users do
  end
  resources :favorites, only: [:create, :destroy]
  resources :feeds do
    collection do
      post :confirm
    end
  end
end
