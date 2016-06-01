require "rails_helper"

RSpec.describe Api::V1::InvoiceMerchantsController do
  before(:each) do
    merchant = Merchant.create(name: "Frank co")
    @invoice = merchant.invoices.create(status: "shipped")
  end

  describe "Get index" do
    it "shows an invoice's merchant" do
      get :show, id: @invoice.id, format: :json
      invoice_merchant_hash = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(invoice_merchant_hash[:name]).to eq "Frank co"
    end
  end
end
