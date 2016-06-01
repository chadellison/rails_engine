require "rails_helper"

RSpec.describe Api::V1::CustomerInvoicesController do
  before(:each) do
    @customer = Customer.create(first_name: "Fred")
    @customer.invoices.create(status: "good")
    @customer.invoices.create(status: "great")
  end

  describe "Get index" do
    it "shows all of a merchant's items" do
      get :index, id: @customer.id, format: :json
      customer_invoices_hash = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(customer_invoices_hash.first[:status]).to eq "good"
      expect(customer_invoices_hash.last[:status]).to eq "great"
    end
  end
end
