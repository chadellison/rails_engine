class ItemSerializer < ActiveModel::Serializer
  # include ActionView::Helpers
  attributes :id, :name, :merchant_id, :description, :unit_price
end
