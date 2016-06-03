class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # before_action :price_to_dollars

  # def price_to_dollars
  #   params[:unit_price] = (params[:unit_price].to_f * 100).round if params[:unit_price]
  # end
end
