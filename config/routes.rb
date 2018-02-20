Rails.application.routes.draw do

  root 'site/pages#home'

  scope module: 'site' do

    resources :products 
    resources :carts, only: [:show, :destroy]
    resources :line_items, only: [:destroy]
    resources :orders, only: [:show]
    
  end


end
