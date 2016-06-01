require "rails_helper"

RSpec.describe Api::V1::MerchantsController do
  before(:each) do
    Merchant.create(name: "Another merchant")
    @merchant = Merchant.create(name: "Jones and Company")
  end

  describe "Get index" do
    it "shows all merchants" do
      get :index, format: :json
      merchants_hash = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(merchants_hash.first[:name]).to eq "Another merchant"
      expect(merchants_hash.last[:name]).to eq "Jones and Company"
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

  describe "Get random" do
    it "returns a random merchant" do
      get :random, format: :json

      merchant_hash = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:success)
      assert merchant_hash.all? { |attribute, value| attribute }
    end
  end

  describe "Get find shows all merchants according to a search criterion" do
    it "works for name" do
      get :find, name: @merchant.name, format: :json
      merchant_hash = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(merchant_hash[:name]).to eq "Jones and Company"
    end

    it "works for created_at" do
      yesterday = Date.today - 1
      merchant = Merchant.create(name: "Franko inc", created_at: yesterday)
      get :find, created_at: yesterday, format: :json
      other_merchant_hash = JSON.parse(response.body, symbolize_names: true)
      expect(other_merchant_hash[:name]).to eq "Franko inc"
    end

    it "works for an id" do
      get :find, id: @merchant.id, format: :json
      merchant_hash = JSON.parse(response.body, symbolize_names: true)
      expect(merchant_hash[:name]).to eq "Jones and Company"
    end

    it "works for updated_at" do
      yesterday = Date.today - 1
      @merchant.update(updated_at: yesterday)

      get :find, updated_at: yesterday, format: :json
      merchant_hash = JSON.parse(response.body, symbolize_names: true)
      expect(merchant_hash[:name]).to eq "Jones and Company"
    end
  end

  describe "Get find_all finds all merchants according to a search criterion" do
    it "works for name" do
      Merchant.create(name: "Another merchant")
      get :find_all, name: "Another merchant", format: :json
      merchants_hash = JSON.parse(response.body, symbolize_names: true)
      expect(merchants_hash.map do |merchant|
        merchant[:name]
      end).to eq ["Another merchant", "Another merchant"]
    end

    it "works for created_at" do
      today = Date.today
      Merchant.create(name: "jill", created_at: today)
      Merchant.create(name: "bobo", created_at: today)
      Merchant.create(name: "pup", created_at: today)

      get :find_all, created_at: Date.today, format: :json

      merchants_hash = JSON.parse(response.body, symbolize_names: true)
      expect(merchants_hash.map do |merchant|
        merchant[:name]
      end).to eq ["jill", "bobo", "pup"]
      expect(merchants_hash.count).to eq 3
    end

    it "works for id" do
      get :find_all, id: @merchant.id, format: :json
      merchants_hash = JSON.parse(response.body, symbolize_names: true)
      expect(merchants_hash.map do |merchant|
        merchant[:name]
      end).to eq ["Jones and Company"]
    end

    it "works for updated_at" do
      @merchant.update(updated_at: Date.today)

      get :find_all, updated_at: Date.today, format: :json
      merchants_hash = JSON.parse(response.body, symbolize_names: true)
      expect(merchants_hash.map do |merchant|
        merchant[:name]
      end).to eq ["Jones and Company"]
    end
  end
end
