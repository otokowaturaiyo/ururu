Rails.application.routes.draw do

  root 'products#index'

    namespace :admins do
    resources :users, only: [:index, :show, :edit, :update]
    resources :products, only:[:new, :create, :index, :show, :edit, :update] do
    resources :reviews, only:[:edit, :update, :destroy]
    end
    resources :orders, only: [:index, :edit, :update]
    get '/top' => 'home#top'
    get '/resign/index' => 'users#resign_index'
    patch '/:id/resign' => 'users#resign', as:'user_resign'
    patch '/:id/revival' => 'users#revival', as:'user_reviva'
  end

  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations'
  }
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }
  namespace :user do
    get 'users/:id/resign' => 'users#resign', as: 'resign'
    patch 'users/:id/resign_confirm' => 'users#resign_confirm', as: 'resign_confirm'
    patch 'users/:id/resign_confirm' => 'users#revival_confirm', as:'revival_confirm'
  end

  get '/products/feature' => 'products#feature'
    resources :products, only:[:show] do
    resources :reviews, only: [:index, :create, :edit, :update, :destroy]
    resources :likes, only: [:create, :destroy]
  end

  resources :users, only:[:show, :edit, :update]

  resources :destinations, only:[:new, :create, :edit, :update]
  resources :carts, only:[:show, :update, :destroy]
  post 'add_item' => 'carts#add_item', as:'add_item'
  get 'search_list' => 'products#search_list'
  get 'genres/:id' => 'genres#show', as: 'genre'


  get '/orders/confirm' => 'orders#confirm', as: 'order_confirm'
  post '/orders/confirm' => 'orders#destination_update', as: 'order_destination'
  post '/orders' => 'orders#create', as: 'orders'
  get '/orders/:id/complete' => 'orders#complete', as:'order_complete'
  resources :orders, only:[:index, :show, :update] do
    collection do
      post 'pay' => 'orders#pay', as: 'pay'
    end
  end




end
