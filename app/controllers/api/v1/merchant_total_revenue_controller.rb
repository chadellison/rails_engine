class Api::V1::MerchantTotalRevenueController < Api::ApiController
  respond_to :json

  def show
    merchant = Merchant.find(params[:id])
    respond_with revenue: merchant.total_revenue(date = params[:date])
  end
end
