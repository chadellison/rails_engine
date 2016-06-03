# require "rails_helper"
#
# RSpec.describe Api::V1::CustomerFavoriteMerchantsController do
#   before(:each) do
#     @customer = Customer.create(first_name: "Jones")
#     merchant1 = Merchant.create(name: "not fav")
#     merchant2 = Merchant.create(name: "jones co")
#     merchant3 = Merchant.create(name: "still not fav")
#
#     invoice1 = Invoice.create(status: "shipped", customer_id: @customer.id, merchant_id: merchant1.id)
#     invoice2 = Invoice.create(status: "shipped", customer_id: @customer.id, merchant_id: merchant2.id)
#     invoice3 = Invoice.create(status: "shipped", customer_id: @customer.id, merchant_id: merchant2.id)
#
#     invoice_items1 = InvoiceItem.create(quantity: 4, invoice_id: invoice1.id)
#     invoice_items2 = InvoiceItem.create(quantity: 4, invoice_id: invoice2.id)
#     invoice_items3 = InvoiceItem.create(quantity: 4, invoice_id: invoice3.id)
#
#     Transaction.create(result: "success", invoice_id: invoice1)
#     Transaction.create(result: "success", invoice_id: invoice2)
#     Transaction.create(result: "success", invoice_id: invoice3)
#   end
#
#   describe "Get show" do
#     it "shows a customer's favorite merchant" do
#       get :show, id: @customer.id, format: :json
#       favorite_merchant_hash = JSON.parse(response.body, symbolize_names: true)
#
#       expect(response).to have_http_status(:success)
#       expect(favorite_merchant_hash[:name]).to eq "jones co"
#     end
#   end
# end
