Rails.application.routes.draw do
<<<<<<< HEAD
  get 'products/index'
=======
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
>>>>>>> e65eb8faf1e34babbbedd2152d33adaf2f3dc282
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
