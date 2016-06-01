class Api::V1::InvoiceItemInvoicesController < Api::ApiController
  respond_to :json

  def show
    invoice_item = InvoiceItem.find(params[:id])
    respond_with invoice_item.invoice
  end
end
