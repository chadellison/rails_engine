require "rails_helper"

RSpec.describe Api::V1::MerchantRevenueByDateController do
  it "shows the total revenue across all merchants for a given date" do
    merchant1 = Merchant.create(name: "bob-jones")
    merchant2 = Merchant.create(name: "top-merchant")
    merchant3 = Merchant.create(name: "second place")

    today = Date.today
    invoice1 = Invoice.create(merchant_id: merchant1.id, created_at: today)
    invoice2 = Invoice.create(merchant_id: merchant2.id, created_at: today)
    invoice3 = Invoice.create(merchant_id: merchant3.id, created_at: today)

    Transaction.create(invoice_id: invoice1.id, result: "success")
    Transaction.create(invoice_id: invoice2.id, result: "success")
    Transaction.create(invoice_id: invoice3.id, result: "success")

    InvoiceItem.create(invoice_id: invoice1.id, unit_price: 300, quantity: 2)
    InvoiceItem.create(invoice_id: invoice2.id, unit_price: 400, quantity: 2)
    InvoiceItem.create(invoice_id: invoice2.id, unit_price: 500, quantity: 2)
    InvoiceItem.create(invoice_id: invoice2.id, unit_price: 500, quantity: 2)
    InvoiceItem.create(invoice_id: invoice3.id, unit_price: 500, quantity: 2)

    get :show, format: :json, date: today
    revenue_hash = JSON.parse(response.body, symbolize_names: true)

    expect(response).to have_http_status :success
    expect(revenue_hash[:revenue]).to eq "44.00"
  end
end
