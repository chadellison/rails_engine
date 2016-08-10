class Api::V1::MerchantRankedByItemsController < Api::ApiController
  respond_to :json

  def index
    respond_with Merchant.rank_by_items(params[:quantity])
  end
end
