class InvoiceItemSerializer < ActiveModel::Serializer
  attributes :id, :invoice_id, :item_id, :quantity, :unit_price

  def unit_price
    sprintf('%.02f', (object.unit_price / 100.0)) if object.unit_price
  end
end
