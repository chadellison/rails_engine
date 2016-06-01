class Api::V1::InvoiceMerchantsController < Api::ApiController
  respond_to :json

  def show
    invoice = Invoice.find(params[:id])
    respond_with invoice.merchant
  end
end
