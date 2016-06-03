RSpec.describe Api::V1::MostItemsController do
  before(:each) do
    merchant = Merchant.create(name: "Jones and company")
    item1 = Item.create(name: "rocks", unit_price: 300)
    item2 = Item.create(name: "soda", unit_price: 500)
    item3 = Item.create(name: "shoes", unit_price: 9000)

    invoice1 = Invoice.create(merchant_id: merchant.id)
    invoice2 = Invoice.create(merchant_id: merchant.id)
    invoice3 = Invoice.create(merchant_id: merchant.id)

    InvoiceItem.create(item_id: item1.id, quantity: 1, unit_price: 300, invoice_id: invoice1.id)
    InvoiceItem.create(item_id: item2.id, quantity: 9, unit_price: 500, invoice_id: invoice2.id)
    InvoiceItem.create(item_id: item3.id, quantity: 4, unit_price: 9000, invoice_id: invoice3.id)

    Transaction.create(result: "success", invoice_id: invoice1.id)
    Transaction.create(result: "success", invoice_id: invoice2.id)
    Transaction.create(result: "success", invoice_id: invoice3.id)
  end

  describe "Get index" do
    it "shows a specified number of items ranked by number sold" do
      get :index, item_count: 2, format: :json
      most_items_hash = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(most_items_hash.count).to eq 2
      expect(most_items_hash.first[:name]).to eq "soda"
    end
  end
end
