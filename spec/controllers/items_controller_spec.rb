require "rails_helper"

RSpec.describe Api::V1::ItemsController do
  before(:each) do
    Item.create(name: "shoe", description: "comfy", unit_price: 9600, merchant_id: 6)
    @item = Item.create(name: "shovel", description: "it shovels", unit_price: 3600, merchant_id: 8)
  end

  describe "Get index" do
    it "shows items" do

      get :index, format: :json
      items_hash = JSON.parse(response.body, symbolize_names: true)
      first_item = items_hash.first
      second_item = items_hash.last

      expect(response).to have_http_status(:success)
      expect(first_item[:name]).to eq "shoe"
      expect(second_item[:description]).to eq "it shovels"
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

  describe "Get random" do
    it "returns a random item" do
      get :random, format: :json

      item_hash = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:success)
      assert item_hash.all? { |attribute, value| attribute }
    end
  end

  describe "Get find shows all items according to a search criterion" do
    it "works for name" do
      get :find, name: @item.name, format: :json
      item_hash = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(item_hash[:name]).to eq "shovel"
    end

    it "works for created_at" do
      yesterday = Date.today - 1
      item = Item.create(name: "ruby gem", created_at: yesterday)

      get :find, created_at: yesterday, format: :json
      other_item_hash = JSON.parse(response.body, symbolize_names: true)
      expect(other_item_hash[:name]).to eq "ruby gem"
    end

    it "works for an id" do
      get :find, id: @item.id, format: :json
      item_hash = JSON.parse(response.body, symbolize_names: true)
      expect(item_hash[:name]).to eq "shovel"
    end

    it "works for updated_at" do
      yesterday = Date.today - 1
      @item.update(updated_at: yesterday)

      get :find, updated_at: yesterday, format: :json
      item_hash = JSON.parse(response.body, symbolize_names: true)
      expect(item_hash[:name]).to eq "shovel"
    end

    it "works for unit_price" do
      get :find, unit_price: 36.00, format: :json
      item_hash = JSON.parse(response.body, symbolize_names: true)
      expect(item_hash[:name]).to eq "shovel"
    end

    it "works for description" do
      get :find, description: @item.description, format: :json
      item_hash = JSON.parse(response.body, symbolize_names: true)
      expect(item_hash[:name]).to eq "shovel"
    end

    it "works for merchant id" do
      get :find, id: @item.id, format: :json
      item_hash = JSON.parse(response.body, symbolize_names: true)
      expect(item_hash[:name]).to eq "shovel"
    end
  end

  describe "Get find_all finds all items according to a search criterion" do
    it "works for name" do
      Item.create(name: "this item")
      Item.create(name: "this item")
      get :find_all, name: "this item", format: :json
      items_hash = JSON.parse(response.body, symbolize_names: true)
      expect(items_hash.map do |item|
        item[:name]
      end).to eq ["this item", "this item"]
    end

    it "works for created_at" do
      today = Date.today
      Item.create(name: "jill", created_at: today)
      Item.create(name: "bobo", created_at: today)
      Item.create(name: "pup", created_at: today)

      get :find_all, created_at: Date.today, format: :json

      merchants_hash = JSON.parse(response.body, symbolize_names: true)
      expect(merchants_hash.map do |item|
        item[:name]
      end).to eq ["jill", "bobo", "pup"]
      expect(merchants_hash.count).to eq 3
    end

    it "works for id" do
      get :find_all, id: @item.id, format: :json
      items_hash = JSON.parse(response.body, symbolize_names: true)
      expect(items_hash.map do |item|
        item[:name]
      end).to eq ["shovel"]
    end

    it "works for updated_at" do
      @item.update(updated_at: Date.today)

      get :find_all, updated_at: Date.today, format: :json
      items_hash = JSON.parse(response.body, symbolize_names: true)
      expect(items_hash.map do |item|
        item[:name]
      end).to eq ["shovel"]
    end

    it "works for unit_price" do
      Item.create(name: "box of rocks", unit_price: 9600)
      get :find_all, unit_price: 96.00, format: :json
      items_hash = JSON.parse(response.body, symbolize_names: true)
      expect(items_hash.map do |item|
        item[:name]
      end).to eq ["shoe", "box of rocks"]
    end

    it "works for description" do
      get :find_all, description: "comfy", format: :json
      items_hash = JSON.parse(response.body, symbolize_names: true)
      expect(items_hash.map do |item|
        item[:name]
      end).to eq ["shoe"]
    end

    it "works for merchant id" do
      get :find_all, merchant_id: 8, format: :json
      items_hash = JSON.parse(response.body, symbolize_names: true)
      expect(items_hash.map do |item|
        item[:name]
      end).to eq ["shovel"]
    end
  end
end
