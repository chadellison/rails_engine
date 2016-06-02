class Api::V1::MerchantRevenueController < Api::ApiController
  respond_to :json

  def index
    respond_with Merchant.top_revenue(params[:quantity])
  end
end
