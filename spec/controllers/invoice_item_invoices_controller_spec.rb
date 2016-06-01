require "rails_helper"

RSpec.describe Api::V1::InvoiceItemInvoicesController do
  before(:each) do
    invoice = Invoice.create(status: "shipped")
    @invoice_item = invoice.invoice_items.create(quantity: 5)
  end

  describe "Get index" do
    it "shows an invoice's merchant" do
      get :show, id: @invoice_item.id, format: :json
      invoice_item_invoice_hash = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(invoice_item_invoice_hash[:status]).to eq "shipped"
    end
  end
end
