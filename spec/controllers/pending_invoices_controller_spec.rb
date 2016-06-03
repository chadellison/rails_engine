require "rails_helper"

RSpec.describe Api::V1::PendingInvoicesController do
  before(:each) do
    @merchant = Merchant.create(name: "Jones and company")
    jones = Customer.create(first_name: "jones")
    frank = Customer.create(first_name: "frank")
    mary = Customer.create(first_name: "mary")

    invoice1 = jones.invoices.create(merchant_id: @merchant.id)
    invoice2 = frank.invoices.create(merchant_id: @merchant.id)
    invoice3 = mary.invoices.create(merchant_id: @merchant.id)

    Transaction.create(result: "failed", invoice_id: invoice1.id)
    Transaction.create(result: "failed", invoice_id: invoice2.id)
    Transaction.create(result: "success", invoice_id: invoice3.id)
  end

  describe "Get index" do
    it "shows all of a merchant's customers with pending invoices" do
      get :index, id: @merchant.id, format: :json
      customers_with_pending_invoices = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(customers_with_pending_invoices.count).to eq 2
      expect(customers_with_pending_invoices.last[:first_name]).to eq "frank"
    end
  end
end
