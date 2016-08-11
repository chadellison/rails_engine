require "rails_helper"

RSpec.describe Api::V1::MerchantRankedByItemsController do
  # before(:each) do
  #   invoice = Invoice.create(status: "this one")
  #   @transaction = Transaction.create(result: "success", invoice_id: invoice.id)
  # end

  describe "Get index" do
    it "shows a variable number of Merchants ranked by items sold" do
      merchant1 = Merchant.create(name: "name1")
      merchant2 = Merchant.create(name: "name2")
      merchant3 = Merchant.create(name: "name3")
      merchant4 = Merchant.create(name: "name4")

      item1 = merchant1.items.create
      item2 = merchant2.items.create
      item3 = merchant3.items.create
      item4 = merchant4.items.create

      invoice1 = Invoice.create
      invoice2 = Invoice.create
      invoice3 = Invoice.create
      invoice4 = Invoice.create

      invoice1.invoice_items.create(quantity: 2)
      invoice2.invoice_items.create(quantity: 3)
      invoice3.invoice_items.create(quantity: 1)
      invoice4.invoice_items.create(quantity: 4)

      merchant1.invoices = [invoice1]
      merchant2.invoices = [invoice2]
      merchant3.invoices = [invoice3]
      merchant4.invoices = [invoice4]

      get :index, quantity: 3, format: :json
      expect(response).to have_http_status(:success)
      merchant_hash = JSON.parse(response.body, symbolize_names: true)

      expect(merchant_hash.first[:name]).to eq "name4"
      expect(merchant_hash[1][:name]).to eq "name2"
      expect(merchant_hash.last[:name]).to eq "name1"
      expect(merchant_hash.count).to eq 3
    end
  end
end
