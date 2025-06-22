Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'registrations'
  }

  # User dashboard
  get 'dashboard', to: 'users#dashboard'

  root 'store#index'

  resources :products do
    collection do
      get :my_ads
    end
  end

  # Cart routes
  get 'cart', to: 'carts#show'
  post 'cart/add_item', to: 'carts#add_item'
  delete 'cart/remove_item', to: 'carts#remove_item'
  delete 'cart/remove_all_of_item', to: 'carts#remove_all_of_item'
  delete 'cart', to: 'carts#destroy'

  # Store routes
  get 'store', to: 'store#index'

  # Payment routes
  resources :payments, only: [:new, :create, :show] do
    member do
      post :confirm
      get :success
    end
  end

  # Convenience routes for payments
  get 'checkout', to: 'payments#new'
  get 'payment_success/:id', to: 'payments#success', as: 'payment_success'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
