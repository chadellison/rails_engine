require "rails_helper"

RSpec.describe Api::V1::InvoiceTransactionsController do
  before(:each) do
    @invoice = Invoice.create(status: "shipped")
    @invoice.transactions.create(invoice_id: @invoice.id, result: "this result")
    @invoice.transactions.create(invoice_id: @invoice.id, result: "this other result")
  end

  describe "Get index" do
    it "shows all of a merchant's invoices" do
      get :index, id: @invoice.id, format: :json
      invoice_transactions_hash = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(invoice_transactions_hash.first[:result]).to eq "this result"
      expect(invoice_transactions_hash.last[:result]).to eq "this other result"
    end
  end
end
