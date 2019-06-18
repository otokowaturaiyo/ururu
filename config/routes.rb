Rails.application.routes.draw do


  namespace :admins do
    resources :users, only: [:index, :show, :edit, :update]
    resources :products, only:[:new, :create, :index, :show, :edit, :update] do
      resources :reviews, only:[:edit, :update, :destroy]
    end
    get '/top' => 'home#top'
    patch 'users/:id/resign' => 'users#resign', as:'admins_user_resign'
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

  get 'users/:id/resign' => 'users#resign', as: 'user_resign'
  patch 'users/:id/resign_confirm' => 'users#resign_confirm', as: 'resign_confirm'


  get '/products/feature' => 'products#feature'
  resources :products, only:[:index, :show] do
    resources :reviews, only: [:index, :create, :edit, :update, :destroy]
    resources :likes, only: [:create, :destroy]
  end

  resources :users, only:[:show, :edit, :update]

  resources :destinations, only:[:new, :create, :edit, :update]
  resources :carts, only:[:create, :show, :update, :destroy]
  get 'search_list' => 'products#search_list'
  get 'genres/:id' => 'genres#show', as: 'genre'


  get '/orders/confirm' => 'orders#confirm', as: 'order_confirm'
  post '/orders' => 'orders#create', as: 'orders'
  get '/orders/:id/complete' => 'orders#complete', as:'order_complete'
  resources :orders, only:[:index, :show]




end
