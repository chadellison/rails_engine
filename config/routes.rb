Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get "items/find", to: "items#find"
      get "items/find_all", to: "items#find_all"
      resources :items, only: [:index, :show]

      get "merchants/find", to: "merchants#find"
      get "merchants/find_all", to: "merchants#find_all"
      resources :merchants, only: [:index, :show]
      resources :customers, only: [:index, :show]

      get "transactions/find", to: "transactions#find"
      get "transactions/find_all", to: "transactions#find_all"
      resources :transactions, only: [:index, :show]
      resources :invoices, only: [:index, :show]
    end
  end

end
