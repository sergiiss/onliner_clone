Rails.application.routes.draw do
  resources :users

  resources :categories do
    collection do
      post 'change_priority'
    end
  end

  resource :sessions, only: [:new, :create ]

  get '/logout', to: "sessions#destroy", as: "logout"
  get '/search_news', to: "posts#search_news", as: "search_news"

  resources :posts do
    resources :comments

    collection do
      post :change_rank
    end
  end

  get '/list', to: "posts#list", as: "list"
  get '/priority_list', to: "categories#priority_list", as: "priority_list"

  resources :comments do
    resources :likes
  end

  root to: "posts#index"
end
