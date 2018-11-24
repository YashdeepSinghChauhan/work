Rails.application.routes.draw do
  
  
  
  devise_for :users
  resources :users do
    collection do
      get 'search'
    end
  end
  resources :users, only: [:index, :show]
 resources :users do
    member do

      get :following
    end
  end
    resources :posts do
      resource :like, module: :posts
      collection do
        get :index, as: :index
      end
      resources :comments, only: [:create, :destroy]
    end
    root 'posts#browse'
    get '/posts/hashtag/:name', to: 'posts#hashtags'
    match :follow, to: 'follows#create', as: :follow, via: :post
    match :unfollow, to: 'follows#destroy', as: :unfollow, via: :post

end
