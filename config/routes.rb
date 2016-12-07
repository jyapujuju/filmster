Rails.application.routes.draw do
  devise_for :users
  resources :reviews, :movies, :users

  resources :relationships, only: [:create, :destroy]
  # resources :relationships  do
  #   resources :users, only: [:create, :destroy]
  #
  # end

  # resources :upvotes, only: :create
  #   # resources :downvotes, only: :create

  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  authenticated :user do
    # root 'authenticated_views#index', as: :authenticated_root
    root 'static_pages#index', as: :authenticated_root
  end

  root 'static_pages#index'


end
