Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get "items/find", to: "items#find"
      get "items/find_all", to: "items#find_all"
      get "items/random", to: "items#random"

      get "items/:id/invoice_items", to: "items_invoice_items#index"
      get "items/:id/merchant", to: "item_merchants#show"
      resources :items, only: [:index, :show]


      get "merchants/:id/items", to: "merchant_items#index"
      get "merchants/:id/invoices", to: "merchant_invoices#index"

      get "merchants/find", to: "merchants#find"
      get "merchants/find_all", to: "merchants#find_all"
      get "merchants/random", to: "merchants#random"
      get "merchants/most_revenue", to: "merchant_revenue#index"
      get "merchants/:id/revenue", to: "merchant_total_revenue#show"
      get "merchants/:id/favorite_customer", to: "merchant_favorite_customers#show"
      resources :merchants, only: [:index, :show]

      get "customers/find", to: "customers#find"
      get "customers/find_all", to: "customers#find_all"
      get "customers/random", to: "customers#random"

      get "customers/:id/invoices", to: "customer_invoices#index"
      get "customers/:id/transactions", to: "customer_transactions#index"
      get "/api/v1/customers/:id/favorite_merchant", to: "customer_favorite_merchants#show"
      resources :customers, only: [:index, :show]

      get "transactions/find", to: "transactions#find"
      get "transactions/find_all", to: "transactions#find_all"
      get "transactions/random", to: "transactions#random"

      get "transactions/:id/invoice", to: "transaction_invoice#show"
      resources :transactions, only: [:index, :show]

      get "invoices/:id/transactions", to: "invoice_transactions#index"
      get "invoices/:id/invoice_items", to: "invoice_invoice_items#index"
      get "invoices/:id/items", to: "invoices_items#index"
      get "invoices/:id/customer", to: "invoice_customers#show"
      get "invoices/:id/merchant", to: "invoice_merchants#show"

      get "invoices/find", to: "invoices#find"
      get "invoices/find_all", to: "invoices#find_all"
      get "invoices/random", to: "invoices#random"
      resources :invoices, only: [:index, :show]

      get "invoice_items/find", to: "invoice_items#find"
      get "invoice_items/find_all", to: "invoice_items#find_all"
      get "invoice_items/random", to: "invoice_items#random"

      get "invoice_items/:id/invoice", to: "invoice_item_invoices#show"
      get "invoice_items/:id/item", to: "invoice_item_items#show"
      resources :invoice_items, only: [:index, :show]
    end
  end
end
