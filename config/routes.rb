Contest::Application.routes.draw do
  # resources :challenges do
  #   member do
  #     get :posts
  #   end
  # end

  resources :challenges do
    resources :posts, controller: 'challenge_posts'
  end

  resources :poll do
    resources :posts, controller: 'poll_posts'
  end

  # resources :challenges do
  #   resources :posts, controller: 'challenge_posts' do
  #     member do
  #       get :vote_for
  #     end
  #   end
  # end

  resources :users do
    member do
      get :challenges
      get :polls
      get :posts
      get :following, :followers
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :posts
  resources :relationships, only: [:create, :destroy]
  
  root  'static_pages#home'
  
  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'

  match '/help',      to: 'static_pages#help',      via: 'get'
  match '/about',     to: 'static_pages#about',     via: 'get'
  match '/contact',   to: 'static_pages#contact',   via: 'get' 
end
