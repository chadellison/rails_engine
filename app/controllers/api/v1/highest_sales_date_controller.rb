class Api::V1::HighestSalesDateController < Api::ApiController
  respond_to :json

  def show
    item = Item.find(params[:id])
    respond_with best_day: item.best_day
  end
end
