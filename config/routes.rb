Rails.application.routes.draw do
  resources :ad_products, only:[:new, :create, :index, :show, :edit, :update]
end
