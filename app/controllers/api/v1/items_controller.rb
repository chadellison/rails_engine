class Api::V1::ItemsController < Api::ApiController
  respond_to :json, :xml

  def index
    respond_with Item.all
  end

  def show
    respond_with Item.find(params[:id])
  end
end
