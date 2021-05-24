Rails.application.routes.draw do

  get 'transactions/show'
  get 'carts/show'
  namespace :admin do
    get 'orders/_admin_order'
    get 'orders/index'
  end
  devise_for :admins
  devise_for :users do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  root to: 'products#index'

  resources :products, only: [:index, :show]
  resources :categories, only: [:show]
  resource :cart, only: [:show] do
    put 'add/:product_id', to: 'carts#add', as: :add_to
    put 'remove/:product_id', to: 'carts#remove', as: :remove_from
    put 'remove_one/:product_id', to: 'carts#removeone', as: :remove_one
  end
  
  resources :transactions, only: [:new, :create] do
    get '/transaction/new' => 'transactions#new'
  end
  
  namespace :admin do
    root to: 'products#index'
    resources :products, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :categories, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :orders, only: [:index]

  end
  namespace :products do
    post 'csv_upload'
  end
  get '/admin/products/:id' => 'admin/products#destroy'
  get '/admin/categories/:id' => 'admin/categories#destroy'
  get '/cart/add/:product_id' => 'carts#add'
end