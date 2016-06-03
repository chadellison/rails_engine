class ItemSerializer < ActiveModel::Serializer
  # include ActionView::Helpers
  attributes :id, :name, :merchant_id, :description, :unit_price

  def unit_price
    sprintf('%.02f', (object.unit_price / 100.0)) if object.unit_price
  end
end
