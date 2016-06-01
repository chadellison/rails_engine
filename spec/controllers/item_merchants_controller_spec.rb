require "rails_helper"

RSpec.describe Api::V1::ItemMerchantsController do
  before(:each) do
    merchant = Merchant.create(name: "jones co")
    @item = merchant.items.create(name: "this item")
  end

  describe "Get index" do
    it "shows an invoice_item's item" do
      get :show, id: @item.id, format: :json
      item_merchant_hash = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(item_merchant_hash[:name]).to eq "jones co"
    end
  end
end
