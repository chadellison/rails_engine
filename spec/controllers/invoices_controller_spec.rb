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
end
