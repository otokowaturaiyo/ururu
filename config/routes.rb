Rails.application.routes.draw do

  get '/products/feature' => 'products#feature'
  get 'genres/:id' => 'genres#show', as: 'genre'
  resources :products, only:[:index, :show] do
  end

  get 'search_list' => 'products#search_list'

  namespace :admins do
    resources :users, only: [:index, :show, :edit, :update]
    resources :products, only:[:new, :create, :index, :show, :edit, :update]
    get '/top' => 'home#top'
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

  resources :users, only:[:show, :edit, :update] do
  end


end

