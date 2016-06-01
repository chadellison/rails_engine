class Api::V1::InvoiceCustomersController < Api::ApiController
  respond_to :json

  def show
    invoice = Invoice.find(params[:id])
    respond_with invoice.customer
  end
end
