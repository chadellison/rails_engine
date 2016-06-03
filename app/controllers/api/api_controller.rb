class Api::ApiController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :price_to_dollars

  def price_to_dollars
    if params[:unit_price]
      params[:unit_price] = (params[:unit_price].to_f * 100).round
    end
  end
end
