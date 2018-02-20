Rails.application.routes.draw do

  devise_for :administrators
  get 'administrators/dashboard', as: 'administrator_root'

  devise_for :customers
  get 'customers/dashboard', as: 'customer_root'

  root 'site/pages#home'

  scope module: 'site' do
    resources :products do
      post 'add_to_cart', on: :member
    end  
    resources :carts, only: [:show, :destroy]
    resources :line_items, only: [:destroy]
    resources :orders, only: [:show]
  end


end
