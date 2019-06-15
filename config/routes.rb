Rails.application.routes.draw do

  get '/products/feature' => 'products#feature'
  get 'genres/:id' => 'genres#show', as: 'genre'

  resources :products, only:[:index, :show]
  resource :favorites, only: [:create, :destroy]
  resources :destinations, only:[:new, :create, :edit, :update]
  resources :carts, only:[:create, :show, :update, :destroy]


  get 'search_list' => 'products#search_list'

  namespace :admins do
    resources :users, only: [:index, :show, :edit, :update]
    resources :products, only:[:new, :create, :index, :show, :edit, :update]
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

  resources :users, only:[:show, :edit, :update]


  get 'users/:id/resign' => 'users#resign', as: 'user_resign'
  patch 'users/:id/resign_confirm' => 'users#resign_confirm', as: 'resign_confirm'


end
