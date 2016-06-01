require "rails_helper"

RSpec.describe Api::V1::MerchantItemsController do
  before(:each) do
    @merchant = Merchant.create(name: "jones and co")
    item1 = Item.create(name: "shoe", description: "comfy", unit_price: 9600, merchant_id: @merchant.id)
    item2 = Item.create(name: "shovel", description: "it shovels", unit_price: 3600, merchant_id: @merchant.id)
  end

  describe "Get index" do
    it "shows all of a merchant's items" do
      get :index, id: @merchant.id, format: :json
      merchant_items_hash = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(merchant_items_hash.first[:name]).to eq "shoe"
      expect(merchant_items_hash.last[:description]).to eq "it shovels"
    end
  end
end
