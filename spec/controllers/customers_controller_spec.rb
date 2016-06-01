require "rails_helper"

RSpec.describe Api::V1::CustomersController do
  before(:each) do
    @customer = Customer.create(first_name: "Jones", last_name: "last name")
    Customer.create(first_name: "another customer", last_name: "another last name")
  end

  describe "Get index" do
    it "shows all customers" do
      get :index, format: :json

      customers_hash = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:success)
      expect(customers_hash.first[:last_name]).to eq "last name"
      expect(customers_hash.last[:first_name]).to eq "another customer"
    end
  end

  describe "Get show" do
    it "shows a single customer" do
      get :show, format: :json, id: @customer.id

      customer_hash = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:success)
      expect(customer_hash[:first_name]).to eq "Jones"
      expect(customer_hash[:last_name]).to eq "last name"
    end
  end

  describe "Get random" do
    it "returns a random customer" do
      get :random, format: :json

      customer_hash = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:success)
      assert customer_hash.all? { |attribute, value| attribute }
    end
  end

  describe "Get find shows all customers according to a search criterion" do
    it "works for first_name" do
      get :find, first_name: "Jones", format: :json
      customer_hash = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(customer_hash[:first_name]).to eq "Jones"
    end

    it "works for created_at" do
      yesterday = Date.today - 1
      customer = Customer.create(first_name: "Frank", created_at: yesterday)
      get :find, created_at: yesterday, format: :json
      other_customer_hash = JSON.parse(response.body, symbolize_names: true)
      expect(other_customer_hash[:first_name]).to eq "Frank"
    end

    it "works for an id" do
      get :find, id: @customer.id, format: :json
      customer_hash = JSON.parse(response.body, symbolize_names: true)
      expect(customer_hash[:first_name]).to eq "Jones"
    end

    it "works for updated_at" do
      yesterday = Date.today - 1
      @customer.update(updated_at: yesterday)

      get :find, updated_at: yesterday, format: :json
      customer_hash = JSON.parse(response.body, symbolize_names: true)
      expect(customer_hash[:first_name]).to eq "Jones"
    end

    it "works for last_name" do
      get :find, last_name: "last name", format: :json
      customer_hash = JSON.parse(response.body, symbolize_names: true)
      expect(customer_hash[:first_name]).to eq "Jones"
    end
  end

  describe "Get find_all finds all customers according to a search criterion" do
    it "works for first_name" do
      Customer.create(first_name: "Jones")
      get :find_all, first_name: "Jones", format: :json
      customers_hash = JSON.parse(response.body, symbolize_names: true)
      expect(customers_hash.map do |customer|
        customer[:first_name]
      end).to eq ["Jones", "Jones"]
    end

    it "works for created_at" do
      today = Date.today
      Customer.create(first_name: "jill", created_at: today)
      Customer.create(first_name: "bobo", created_at: today)
      Customer.create(first_name: "pup", created_at: today)

      get :find_all, created_at: Date.today, format: :json

      customers_hash = JSON.parse(response.body, symbolize_names: true)
      expect(customers_hash.map do |customer|
        customer[:first_name]
      end).to eq ["jill", "bobo", "pup"]
      expect(customers_hash.count).to eq 3
    end

    it "works for id" do
      get :find_all, id: @customer.id, format: :json
      customers_hash = JSON.parse(response.body, symbolize_names: true)
      expect(customers_hash.map do |customer|
        customer[:first_name]
      end).to eq ["Jones"]
    end

    it "works for updated_at" do
      @customer.update(updated_at: Date.today)

      get :find_all, updated_at: Date.today, format: :json
      customers_hash = JSON.parse(response.body, symbolize_names: true)
      expect(customers_hash.map do |customer|
        customer[:first_name]
      end).to eq ["Jones"]
    end

    it "works for last_name" do
      get :find_all, last_name: "another last name", format: :json
      customers_hash = JSON.parse(response.body, symbolize_names: true)
      expect(customers_hash.map do |customer|
        customer[:first_name]
      end).to eq ["another customer"]
    end
  end
end
