Rails.application.routes.draw do
  resources :users

  resources :categories

  resource :sessions, only: [:new, :create ]

  get '/logout', to: "sessions#destroy", as: "logout"

  resources :posts do
    resources :comments

    collection do
      post :change_rank
    end
  end

  get '/list', to: "posts#list", as: "list"

  get '/people', to: "posts#people", as: "people"
  get '/technologies', to: "posts#technologies", as: "technologies"
  get '/opinions', to: "posts#opinions", as: "opinions"
  get '/auto', to: "posts#auto", as: "auto"
  get '/realty', to: "posts#realty", as: "realty"

  resources :comments do
    resources :likes
  end

  root to: "posts#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
