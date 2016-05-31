require "rails_helper"

RSpec.describe Api::V1::ItemsController do
  before(:each) do
    @item = Item.create(name: "shovel", description: "it shovels", unit_price: 3600, merchant_id: 8)
    Item.create(name: "shoe", description: "comfy", unit_price: 9600, merchant_id: 6)
  end

  describe "Get index" do
    it "shows items" do

      get :index, format: :json
      items_hash = JSON.parse(response.body, symbolize_names: true)
      first_item = items_hash.first
      second_item = items_hash.last

      expect(response).to have_http_status(:success)
      expect(first_item[:name]).to eq "shovel"
      expect(second_item[:description]).to eq "comfy"
    end
  end
  describe "Get show" do
    it "shows a single item" do
      id = @item.id
      get :show, format: :json, id: id

      item_hash = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:success)
      expect(item_hash[:name]).to eq "shovel"
      expect(item_hash[:name]).to eq "shovel"
    end
  end
end
