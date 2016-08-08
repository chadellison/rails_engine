class Item < ActiveRecord::Base
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.most_revenue(item_count)
    joins(invoice_items: :transactions)
      .where("transactions.result = 'success'")
      .group(:id)
      .order("sum(invoice_items.unit_price * invoice_items.quantity) desc")
      .limit(item_count.to_i)
  end

  def self.most_items(item_count)
    joins(invoice_items: :transactions)
      .where("transactions.result = 'success'")
      .group(:id)
      .order("sum(invoice_items.quantity) desc")
      .limit(item_count.to_i)
  end

  def best_day
    best_invoice_items = invoice_items.joins(:transactions)
      .where("transactions.result = 'success'")
      .order(quantity: :desc)
    best_invoice_items.where(quantity: best_invoice_items.first.quantity)
      .map(&:invoice).max_by(&:created_at).created_at
  end
end
