Rails.application.routes.draw do
  resources :orders, only: %i[index show]

  root to: 'orders#index'
end
