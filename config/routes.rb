Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  devise_for :users
  resources :products
  resources :categories
  resource :cart, only: [:show, :update, :destroy] do
    post 'add_product/:product_id', to: 'carts#add_product', as: 'add_product'
    patch 'update_quantity/:id', to: 'carts#update_quantity', as: 'update_quantity'
    delete 'remove_item/:id', to: 'carts#remove_item', as: 'remove_item'
  end
  resources :orders do
    collection do
      get 'checkout'
    end
  end
  root 'products#index'
end
