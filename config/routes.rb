Contest::Application.routes.draw do
  root  'static_pages#home'

  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'

  match '/help',      to: 'static_pages#help',      via: 'get'
  match '/about',     to: 'static_pages#about',     via: 'get'
  match '/contact',   to: 'static_pages#contact',   via: 'get' 

  resources :sessions, only: [:new, :create, :destroy]
  resources :comments
  resources :relationships, only: [:create, :destroy]

  resources :posts do
    resources :comments
  end

  resources :challenges do
    resources :comments
    resources :posts, controller: 'challenge_posts' do
      resources :votes, :only => [:create]
    end
  end

  resources :votes, :only => [:create] 

  resources :polls do
    resources :comments
    resources :posts, controller: 'poll_posts' do
      resources :votes, :only => [:create]
    end
  end

  resources :users do
    resources :comments
    member do
      get :challenges
      get :polls
      get :posts
      get :following, :followers
    end
  end
  
  # resources :challenges do
  #   resources :posts, controller: 'challenge_posts' do
  #     member do
  #       get :vote_for
  #     end
  #   end
  # end

  # resources :challenges do
  #   member do
  #     get :posts
  #   end
  # end
  
end
