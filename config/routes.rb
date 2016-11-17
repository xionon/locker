Rails.application.routes.draw do
  resources :orders, only: %i[index create destroy] do
    resources :bulk_shipments, only: %i[create]
  end

  resources :purchases, only: [] do
    resources :shipments, only: %i[create]
  end

  mount ActionCable.server => '/cable'
  root to: 'orders#index'
end
