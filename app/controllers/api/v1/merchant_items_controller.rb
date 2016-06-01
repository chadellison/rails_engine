class Api::V1::MerchantItemsController < Api::ApiController
  respond_to :json

  def index
    merchant = Merchant.find(params[:id])
    respond_with merchant.items
  end
end
