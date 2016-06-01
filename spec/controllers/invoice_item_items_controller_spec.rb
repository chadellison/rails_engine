require "rails_helper"

RSpec.describe Api::V1::InvoiceItemItemsController do
  before(:each) do
    item = Item.create(name: "jones")
    @invoice_item = item.invoice_items.create(quantity: 5)
  end

  describe "Get index" do
    it "shows an invoice_item's item" do
      get :show, id: @invoice_item.id, format: :json
      invoice_item_invoice_hash = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(invoice_item_invoice_hash[:name]).to eq "jones"
    end
  end
end
