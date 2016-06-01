require "rails_helper"

RSpec.describe Api::V1::InvoicesController do
  before(:each) do
    @customer1 = Customer.create(first_name: "Jones", last_name: "last name")
    @customer2 = Customer.create(first_name: "Rosco", last_name: "another last name")

    @merchant1 = Merchant.create(name: "jamba")
    @merchant2 = Merchant.create(name: "cran")

    Invoice.create(customer_id: @customer2.id, merchant_id: @merchant1.id, status: "shipped")
    @invoice = Invoice.create(customer_id: @customer1.id, merchant_id: @merchant2.id, status: "shipped")
  end

  describe "Get index" do
    it "shows all invoices" do
      get :index, format: :json

      invoices_hash = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(invoices_hash.first[:customer_id]).to eq @customer2.id
      expect(invoices_hash.last[:merchant_id]).to eq @merchant2.id
    end
  end

  describe "Get show" do
    it "shows a single invoice" do
      get :show, format: :json, id: @invoice.id

      invoice_hash = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(invoice_hash[:customer_id]).to eq @customer1.id
      expect(invoice_hash[:merchant_id]).to eq @merchant2.id
    end
  end

  describe "Get random" do
    it "returns a random invoice" do
      get :random, format: :json

      invoice_hash = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:success)
      assert invoice_hash.all? { |attribute, value| attribute }
    end
  end

  describe "Get find shows all invoices according to a search criterion" do
    it "works for id" do
      get :find, id: @invoice.id, format: :json
      invoice_hash = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(invoice_hash[:id]).to eq @invoice.id
      expect(invoice_hash[:customer_id]).to eq @customer1.id
    end

    it "works for created_at" do
      yesterday = Date.today - 1
      item = Invoice.create(customer_id: @customer_id, created_at: yesterday)

      get :find, created_at: yesterday, format: :json
      other_invoice_hash = JSON.parse(response.body, symbolize_names: true)
      expect(other_invoice_hash[:customer_id]).to eq @customer_id
    end

    it "works for a merchant_id" do
      get :find, merchant_id: @merchant2.id, format: :json
      invoice_hash = JSON.parse(response.body, symbolize_names: true)
      expect(invoice_hash[:id]).to eq @invoice.id
    end

    it "works for updated_at" do
      yesterday = Date.today - 1
      @invoice.update(updated_at: yesterday)

      get :find, updated_at: yesterday, format: :json
      invoice_hash = JSON.parse(response.body, symbolize_names: true)
      expect(invoice_hash[:id]).to eq @invoice.id
    end

    it "works for status" do
      get :find, status: "shipped", format: :json
      invoice_hash = JSON.parse(response.body, symbolize_names: true)
      expect(invoice_hash[:customer_id]).to eq @customer2.id
    end
  end

  describe "Get find_all finds all invoices according to a search criterion" do
    it "works for id" do
      get :find_all, id: @invoice.id, format: :json
      invoice_hash = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(invoice_hash.map { |inv| inv[:id] }).to eq [@invoice.id]
      expect(invoice_hash.map { |inv| inv[:customer_id]}).to eq [@customer1.id]
    end

    it "works for created_at" do
      today = Date.today
      Invoice.create(customer_id: @customer1.id, created_at: today)
      Invoice.create(customer_id: @customer1.id, created_at: today)
      Invoice.create(customer_id: @customer1.id, created_at: today)

      get :find_all, created_at: Date.today, format: :json

      merchants_hash = JSON.parse(response.body, symbolize_names: true)
      expect(merchants_hash.map do |item|
        item[:customer_id]
      end).to eq [@customer1.id, @customer1.id, @customer1.id]
      expect(merchants_hash.count).to eq 3
    end

    it "works for merchant_id" do
      get :find_all, merchant_id: @merchant2.id, format: :json
      invoices_hash = JSON.parse(response.body, symbolize_names: true)
      expect(invoices_hash.map do |item|
        item[:id]
      end).to eq [@invoice.id]
    end

    it "works for status" do
      get :find_all, status: "shipped", format: :json
      invoices_hash = JSON.parse(response.body, symbolize_names: true)
      expect(invoices_hash.map do |item|
        item[:customer_id]
      end).to eq [@customer2.id, @customer1.id]
    end
  end
end
