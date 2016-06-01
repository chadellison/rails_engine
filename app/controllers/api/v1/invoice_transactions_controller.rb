class Api::V1::InvoiceTransactionsController < Api::ApiController
  respond_to :json

  def index
    invoice = Invoice.find(params[:id])
    respond_with invoice.transactions
  end
end
