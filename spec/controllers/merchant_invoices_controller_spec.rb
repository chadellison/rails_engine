require "rails_helper"

RSpec.describe Api::V1::MerchantInvoicesController do
  before(:each) do
    @merchant = Merchant.create(name: "Jones and company")
    @merchant.invoices.create(status: "shipped")
    @merchant.invoices.create(status: "another status")
  end

  describe "Get index" do
    it "shows all of a merchant's invoices" do
      get :index, id: @merchant.id, format: :json
      merchant_invoices_hash = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(merchant_invoices_hash.first[:status]).to eq "shipped"
      expect(merchant_invoices_hash.last[:status]).to eq "another status"
    end
  end
end
