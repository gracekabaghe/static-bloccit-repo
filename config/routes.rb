Bloccit::Application.routes.draw do


  get "posts/index"

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }
    # create a route for users#show
    resources :topics do
    resources :posts, except: [:index], controller: 'topics/posts' do
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
    resources :posts, only: [:index]
    resources :users, only: [:show, :index]
    
    match '/up-vote', to: 'votes#up_vote', as: :up_vote
    match '/down-vote', to: 'votes#down_vote', as: :down_vote
    end
  end

  match "about" => 'welcome#about', via: :get
  authenticated :user do
    root :to => 'topics#index'
  end

  root :to => 'welcome#index'
end