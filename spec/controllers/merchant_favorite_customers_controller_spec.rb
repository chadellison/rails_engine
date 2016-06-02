require "rails_helper"

RSpec.describe Api::V1::MerchantFavoriteCustomersController do
  before(:each) do
    @merchant = Merchant.create(name: "bob-jones")

    customer1 = Customer.create(first_name: "bill")
    customer2 = Customer.create(first_name: "jones")
    customer3 = Customer.create(first_name: "martha")

    invoice1 = Invoice.create(merchant_id: @merchant.id, customer_id: customer1.id)
    @invoice2 = Invoice.create(merchant_id: @merchant.id, customer_id: customer2.id)
    invoice3 = Invoice.create(merchant_id: @merchant.id, customer_id: customer2.id)
    invoice4 = Invoice.create(merchant_id: @merchant.id, customer_id: customer3.id)

    Transaction.create(result: "success", invoice_id: invoice1.id)
    Transaction.create(result: "success", invoice_id: @invoice2.id)
    Transaction.create(result: "success", invoice_id: invoice3.id)
    Transaction.create(result: "success", invoice_id: invoice4.id)
  end

  describe "Get index" do
    it "shows a merchant's favorite customer" do
      get :show, format: :json, id: @merchant.id
      favorite_customer = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(favorite_customer[:first_name]).to eq "jones"
    end
  end
end
