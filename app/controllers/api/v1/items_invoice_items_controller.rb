class Api::V1::ItemsInvoiceItemsController < Api::ApiController
  respond_to :json

  def index
    item = Item.find(params[:id])
    respond_with item.invoice_items
  end
end
