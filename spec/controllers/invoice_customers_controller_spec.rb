require "rails_helper"

RSpec.describe Api::V1::InvoiceCustomersController do
  before(:each) do
    customer = Customer.create(first_name: "Frank")
    @invoice = customer.invoices.create(status: "shipped")
  end

  describe "Get index" do
    it "shows all of a merchant's customers" do
      get :show, id: @invoice.id, format: :json
      invoices_items_hash = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(invoices_items_hash[:first_name]).to eq "Frank"
    end
  end
end
