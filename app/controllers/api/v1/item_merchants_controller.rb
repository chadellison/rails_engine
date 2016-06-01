class Api::V1::ItemMerchantsController < Api::ApiController
  respond_to :json

  def show
    item = Item.find(params[:id])
    respond_with item.merchant
  end
end
