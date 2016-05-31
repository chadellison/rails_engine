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
end
