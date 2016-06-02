class InvoiceItemSerializer < ActiveModel::Serializer
  include ActionView::Helpers

  attributes :id, :invoice_id, :item_id, :quantity, :unit_price

  def unit_price
    number_to_currency(unit_price_in_cents, unit: "")
  end

  private

  def unit_price_in_cents
    object.unit_price / 100.0 if object.unit_price
  end
end
