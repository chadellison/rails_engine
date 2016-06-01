class Api::V1::InvoicesItemsController < Api::ApiController
  respond_to :json

  def index
    invoice = Invoice.find(params[:id])
    respond_with invoice.items
  end
end
