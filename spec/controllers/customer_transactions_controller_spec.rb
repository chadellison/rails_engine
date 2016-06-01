require "rails_helper"

RSpec.describe Api::V1::CustomerTransactionsController do
  before(:each) do
    @customer = Customer.create(first_name: "Frank")
    invoice = @customer.invoices.create(status: "happy")
    transaction = Transaction.create(result: "yay", invoice_id: invoice.id)
  end

  describe "Get index" do
    it "shows all of a customer's transactions" do
      get :index, id: @customer.id, format: :json
      customer_transactions_hash = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(customer_transactions_hash.last[:result]).to eq "yay"
    end
  end
end
