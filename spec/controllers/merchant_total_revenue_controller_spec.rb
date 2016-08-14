require "rails_helper"

RSpec.describe Api::V1::MerchantTotalRevenueController do
  before(:each) do
    @merchant = Merchant.create(name: "bob-jones")

    invoice1 = Invoice.create(merchant_id: @merchant.id)
    @invoice2 = Invoice.create(merchant_id: @merchant.id, created_at: Date.today)
    invoice3 = Invoice.create(merchant_id: @merchant.id)
    invoice4 = Invoice.create(merchant_id: @merchant.id, created_at: Date.today)

    Transaction.create(invoice_id: invoice1.id, result: "success")
    Transaction.create(invoice_id: @invoice2.id, result: "success")
    Transaction.create(invoice_id: invoice3.id, result: "failed")
    Transaction.create(invoice_id: invoice4.id, result: "success")

    InvoiceItem.create(invoice_id: invoice1.id, unit_price: 300, quantity: 2)
    InvoiceItem.create(invoice_id: @invoice2.id, unit_price: 400, quantity: 2)
    InvoiceItem.create(invoice_id: @invoice2.id, unit_price: 500, quantity: 2)
    InvoiceItem.create(invoice_id: @invoice2.id, unit_price: 500, quantity: 2)
    InvoiceItem.create(invoice_id: invoice3.id, unit_price: 500, quantity: 2)
    InvoiceItem.create(invoice_id: invoice4.id, unit_price: 100, quantity: 2)
  end

  describe "Get index" do
    it "shows a merchant's total revenue" do
      get :show, format: :json, id: @merchant.id
      total_revenue = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(total_revenue[:revenue]).to eq "36.00"
    end
  end

  describe "Get show" do
    it "shows a merchant's total revenue by an invoice date" do
      get :show, id: @merchant.id, date: @invoice2.created_at, format: :json

      total_revenue = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(total_revenue[:revenue]).to eq "30.00"
    end
  end
end
