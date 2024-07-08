Rails.application.routes.draw do
  devise_for :users
  resources :products, only: [:index, :show]
  resources :categories, only: [:index, :show]
  resource :cart, only: [:show] do
    post 'add_product', on: :member
    patch 'update_quantity', on: :member
    delete 'remove_item', on: :member
  end
  resources :orders, only: [:index, :show, :new, :create]

  root to: 'home#index'
end
