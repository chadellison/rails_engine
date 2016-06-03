require "rails_helper"

RSpec.describe Api::V1::InvoiceItemsController do
  before(:each) do
    @customer = Customer.create(first_name: "Jones", last_name: "last")
    @merchant = Merchant.create(name: "Jones and company")
    @item = Item.create(name: "box of rocks", description: "they are heavy", unit_price: 4000, merchant_id: @merchant.id)
    @invoice = Invoice.create(customer_id: @customer.id, merchant_id: @merchant.id, status: "shipped")
    InvoiceItem.create(item_id: @item.id, invoice_id: @invoice.id, quantity: 2, unit_price: 300)
    @invoice_item = InvoiceItem.create(item_id: @item.id, invoice_id: @invoice.id, quantity: 8, unit_price: 300)
  end

  describe "Get index" do
    it "shows invoices" do

      get :index, format: :json
      invoices_hash = JSON.parse(response.body, symbolize_names: true)
      first_invoice = invoices_hash.first
      second_invoice = invoices_hash.last

      expect(response).to have_http_status(:success)
      expect(first_invoice[:invoice_id]).to eq @invoice.id
      expect(second_invoice[:quantity]).to eq 8
    end
  end

  describe "Get show" do
    it "shows a single invoice" do
      id = @invoice_item.id
      get :show, format: :json, id: id

      invoice_hash = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:success)
      expect(invoice_hash[:unit_price]).to eq 300
      expect(invoice_hash[:invoice_id]).to eq @invoice.id
    end
  end

  describe "Get random" do
    it "returns a random invoice_item" do
      get :random, format: :json

      invoice_hash = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:success)
      assert invoice_hash.all? { |attribute, value| attribute }
    end
  end

  describe "Get find shows all invoices according to a search criterion" do
    it "works for item_id" do
      get :find, item_id: @invoice_item.item_id, format: :json
      invoice_item_hash = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(invoice_item_hash[:item_id]).to eq @invoice_item.item_id
    end

    it "works for created_at" do
      yesterday = Date.today - 1
      @invoice_item.update(created_at: yesterday)

      get :find, created_at: yesterday, format: :json
      other_invoice_hash = JSON.parse(response.body, symbolize_names: true)
      expect(other_invoice_hash[:item_id]).to eq @item.id
    end

    it "works for an id" do
      get :find, id: @invoice_item.id, format: :json
      invoice_hash = JSON.parse(response.body, symbolize_names: true)
      expect(invoice_hash[:item_id]).to eq @invoice_item.item_id
    end

    it "works for updated_at" do
      yesterday = Date.today - 1
      @invoice_item.update(updated_at: yesterday)

      get :find, updated_at: yesterday, format: :json
      invoice_hash = JSON.parse(response.body, symbolize_names: true)
      expect(invoice_hash[:item_id]).to eq @item.id
    end

    it "works for unit_price" do
      get :find, unit_price: @invoice_item.unit_price, format: :json
      invoice_hash = JSON.parse(response.body, symbolize_names: true)
      expect(invoice_hash[:item_id]).to eq @item.id
    end

    it "works for quantity" do
      get :find, quantity: @invoice_item.quantity, format: :json
      invoice_item_hash = JSON.parse(response.body, symbolize_names: true)
      expect(invoice_item_hash[:quantity]).to eq 8
    end

    it "works for invoice id" do
      get :find, invoice_id: @invoice_item.invoice_id, format: :json
      invoice_hash = JSON.parse(response.body, symbolize_names: true)
      expect(invoice_hash[:item_id]).to eq @item.id
    end
  end

  describe "Get find_all finds all invoices according to a search criterion" do
    it "works for item_id" do
      get :find_all, item_id: @invoice_item.item_id, format: :json
      invoices_hash = JSON.parse(response.body, symbolize_names: true)
      expect(invoices_hash.map do |invoice|
        invoice[:item_id]
      end).to eq [@item.id, @item.id]
    end

    it "works for created_at" do
      today = Date.today
      @invoice_item.update(created_at: today)
      get :find_all, created_at: Date.today, format: :json

      merchants_hash = JSON.parse(response.body, symbolize_names: true)
      expect(merchants_hash.map do |invoice|
        invoice[:item_id]
      end).to eq [@invoice_item.item_id]
    end

    it "works for id" do
      get :find_all, id: @invoice_item.id, format: :json
      invoices_hash = JSON.parse(response.body, symbolize_names: true)
      expect(invoices_hash.map do |invoice|
        invoice[:item_id]
      end).to eq [@invoice_item.item_id]
    end

    it "works for updated_at" do
      @invoice_item.update(updated_at: Date.today)

      get :find_all, updated_at: Date.today, format: :json
      invoices_hash = JSON.parse(response.body, symbolize_names: true)
      expect(invoices_hash.map do |invoice|
        invoice[:item_id]
      end).to eq [@invoice_item.item_id]
    end

    it "works for unit_price" do
      get :find_all, unit_price: @invoice_item.unit_price, format: :json
      invoices_hash = JSON.parse(response.body, symbolize_names: true)
      expect(invoices_hash.map do |invoice|
        invoice[:item_id]
      end).to eq [@invoice_item.item_id, @invoice_item.item_id]
    end

    it "works for quantity" do
      get :find_all, quantity: 8, format: :json
      invoices_hash = JSON.parse(response.body, symbolize_names: true)
      expect(invoices_hash.map do |invoice|
        invoice[:item_id]
      end).to eq [@invoice_item.item_id]
    end

    it "works for invoice id" do
      get :find_all, invoice_id: @invoice_item.invoice_id, format: :json
      invoices_hash = JSON.parse(response.body, symbolize_names: true)
      expect(invoices_hash.map do |invoice|
        invoice[:item_id]
      end).to eq [@invoice_item.item_id, @invoice_item.item_id]
    end
  end
end
