Rails.application.routes.draw do
  root 'customers#index'
  resources :customers
  resources :orders

  # routes to seven different actions: index, new, create, show, edit, update, destroy
  # route helpers are generated as well: orders_path, new_order_path, edit_order_path, order_path
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
