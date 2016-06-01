require "rails_helper"

RSpec.describe Api::V1::TransactionInvoiceController do
  before(:each) do
    invoice = Invoice.create(status: "this one")
    @transaction = Transaction.create(result: "success", invoice_id: invoice.id)
  end

  describe "Get index" do
    it "shows a transaction's invoice" do
      get :show, id: @transaction.id, format: :json
      transaction_invoice_hash = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(transaction_invoice_hash[:status]).to eq "this one"
    end
  end
end
