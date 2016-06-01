require "rails_helper"

RSpec.describe Api::V1::InvoicesItemsController do
  before(:each) do
    @invoice = Invoice.create(status: "shipped")
    @invoice.items.create(name: "item")
    @invoice.items.create(name: "this item")
  end

  describe "Get index" do
    it "shows all of a merchant's invoices" do
      get :index, id: @invoice.id, format: :json
      invoices_items_hash = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(invoices_items_hash.first[:name]).to eq "item"
      expect(invoices_items_hash.last[:name]).to eq "this item"
    end
  end
end
