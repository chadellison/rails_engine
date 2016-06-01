require "rails_helper"

RSpec.describe Api::V1::ItemsInvoiceItemsController do
  before(:each) do
    @item = Item.create(name: "name")
    @item.invoice_items.create(quantity: 9)
    @item.invoice_items.create(quantity: 10)
  end

  describe "Get index" do
    it "shows all of an item's invoice_items" do
      get :index, id: @item.id, format: :json
      items_invoice_items_hash = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(items_invoice_items_hash.first[:quantity]).to eq 9
      expect(items_invoice_items_hash.last[:quantity]).to eq 10
    end
  end
end
