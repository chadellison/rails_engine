class Item < ActiveRecord::Base
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.most_revenue(item_count)
    joins(invoice_items: :transactions)
      .where("transactions.result = 'success'")
      .group(:id)
      .order("sum(invoice_items.unit_price * invoice_items.quantity) desc")
      .limit(item_count)
  end

  def self.most_items(item_count)
    joins(invoice_items: :transactions)
      .where("transactions.result = 'success'")
      .group(:id)
      .order("sum(invoice_items.quantity) desc")
      .limit(item_count)
  end
end
