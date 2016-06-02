class Api::V1::MerchantFavoriteCustomersController < Api::ApiController
  respond_to :json

  def show
    merchant = Merchant.find(params[:id])
    respond_with merchant.favorite_customer
  end
end
