require "rails_helper"

RSpec.describe Api::V1::InvoiceInvoiceItemsController do
  before(:each) do
    @invoice = Invoice.create(status: "shipped")
    @invoice.invoice_items.create(invoice_id: @invoice.id, quantity: 9)
    @invoice.invoice_items.create(invoice_id: @invoice.id, quantity: 10)
  end

  describe "Get index" do
    it "shows all of a merchant's invoices" do
      get :index, id: @invoice.id, format: :json
      invoice_invoice_items_hash = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(invoice_invoice_items_hash.first[:quantity]).to eq 9
      expect(invoice_invoice_items_hash.last[:quantity]).to eq 10
    end
  end
end
