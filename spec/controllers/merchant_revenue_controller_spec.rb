require "rails_helper"

RSpec.describe Api::V1::MerchantRevenueController do
#   before(:each) do
#     merchant1 = Merchant.create(name: "bob-jones")
#     merchant2 = Merchant.create(name: "top-merchant")
#     merchant3 = Merchant.create(name: "second place")
#
#     invoice1 = Invoice.create(merchant_id: merchant1.id)
#     invoice2 = Invoice.create(merchant_id: merchant2.id)
#     invoice3 = Invoice.create(merchant_id: merchant3.id)
#
#     Transaction.create(invoice_id: invoice1.id, result: "success")
#     Transaction.create(invoice_id: invoice2.id, result: "success")
#     Transaction.create(invoice_id: invoice3.id, result: "success")
#
#     InvoiceItem.create(invoice_id: invoice1.id, unit_price: 300, quantity: 2)
#     InvoiceItem.create(invoice_id: invoice2.id, unit_price: 400, quantity: 2)
#     InvoiceItem.create(invoice_id: invoice2.id, unit_price: 500, quantity: 2)
#     InvoiceItem.create(invoice_id: invoice2.id, unit_price: 500, quanitty: 2)
#     InvoiceItem.create(invoice_id: invoice3.id, unit_price: 500, quantity: 2)
#   end
#
#   describe "Get index" do
#     it "shows a specified number of top merchants by revenue" do
#       get :index, format: :json, quantity: 2
#       merchant_revenue_hash = JSON.parse(response.body, symbolize_names: true)
#
#       expect(response).to have_http_status(:success)
#       refute merchant_revenue_hash[2]
#       expect(merchant_revenue_hash.first[:name]).to eq "top-merchant"
#       expect(merchant_revenue_hash.last[:name]).to eq "second place"
#     end
#   end
end
