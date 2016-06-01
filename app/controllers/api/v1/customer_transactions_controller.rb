class Api::V1::CustomerTransactionsController < Api::ApiController
  respond_to :json

  def index
    customer = Customer.find(params[:id])
    respond_with customer.transactions
  end
end
