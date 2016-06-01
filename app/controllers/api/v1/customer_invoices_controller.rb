class Api::V1::CustomerInvoicesController < Api::ApiController
  respond_to :json

  def index
    customer = Customer.find(params[:id])
    respond_with customer.invoices
  end
end
