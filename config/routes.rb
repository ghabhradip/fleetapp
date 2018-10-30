Rails.application.routes.draw do

  resources :home do
    member do
        get :blacklist_user
        get :activate_user
    end

    collection do
        get :list_blogs
    end
  end

  resources :home

  resources :blog

  #devise_for :users
  devise_for :users, :controllers => { registrations: 'registrations', sessions: 'sessions'}


  devise_scope :user do
      authenticated :user do
        root 'blog#index', as: :authenticated_root
      end

      unauthenticated do
        root 'devise/sessions#new', as: :unauthenticated_root
      end
  end


  namespace :api do
    namespace :v1 do |v1|
      post '/users/details' => 'users#details'
      get '/users/all_users' => 'users#all_users'

      post '/blog/user_blogs' => 'blog#user_blogs'
      get '/blog/all_blogs' => 'blog#all_blogs'
      post '/blog/get_blog' => 'blog#get_blog'

      get 'sessions/get_authenticity_token' => 'sessions#retrieve_authenticity_token'
      post 'sessions/login' => 'sessions#create' 
      post 'sessions/logout' => 'sessions#destroy'      
    end
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
