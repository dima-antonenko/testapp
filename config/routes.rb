Rails.application.routes.draw do

  devise_for :administrators
  get 'administrators/dashboard', as: 'administrator_root'

  devise_for :customers
  get 'customers/dashboard', as: 'customer_root'

  root 'site/pages#home'


  namespace :administrators do
    resources :product_categories, only: [:index, :create] do
      get 'add_children', on: :member
      get 'add_product', on: :member
    end
    resources :products, only: [:index]
    resources :orders, only: [:index, :show]  
  end  

  scope module: 'site' do
    resources :products, only: [:show] do
      post 'add_to_cart', on: :member
    end  
    resources :carts, only: [:show, :destroy] do
      post 'remove_item', on: :member
    end  

    resources :orders, only: [:create]
  end


end
