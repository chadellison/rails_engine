require "rails_helper"

RSpec.describe Api::V1::MerchantsController do
  before(:each) do
    @merchant = Merchant.create(name: "Jones and Company")
    Merchant.create(name: "Another merchant")
  end

  describe "Get index" do
    it "shows all merchants" do
      get :index, format: :json
      merchants_hash = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(merchants_hash.first[:name]).to eq "Jones and Company"
      expect(merchants_hash.last[:name]).to eq "Another merchant"
    end
  end

  describe "Get show" do
    it "shows a single merchant" do
      get :show, format: :json, id: @merchant.id
      merchant_hash = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(merchant_hash[:name]).to eq "Jones and Company"
    end
  end
end
