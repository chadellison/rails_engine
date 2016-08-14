class Api::V1::MerchantRevenueByDateController < Api::ApiController
  respond_to :json

  def show
    respond_with total_revenue: Merchant.revenue_by_date(params[:date])
  end
end
