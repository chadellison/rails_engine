class Api::V1::MostItemsController < Api::ApiController
  respond_to :json

  def index
    respond_with Item.most_items(params[:item_count])
  end
end
