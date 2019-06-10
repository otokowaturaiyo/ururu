Rails.application.routes.draw do


  resources :products, only:[:index, :show] do
  end


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

  resources :users, only:[:show] do
  end

end
