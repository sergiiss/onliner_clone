Rails.application.routes.draw do
  resources :users

  resource :sessions, only: [:new, :create, :destroy]

  get "sessions/destroy"
  get '/list', to: "posts#list", as: "list"

  resources :posts do
    resources :comments
  end

  resources :comments do
    resources :likes
  end

  root to: "posts#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
