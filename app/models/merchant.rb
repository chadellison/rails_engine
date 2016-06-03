class Merchant < ActiveRecord::Base
  has_many :items
  has_many :invoices

  def self.top_revenue(merchant_count)

  end

  def total_revenue(date)
    date ? invoices = Invoice.where(created_at: date) : invoices = Invoice
    invoices.joins(:invoice_items, :transactions)
      .where(transactions: {result: "success"})
      .where(merchant_id: id)
      .sum("unit_price * quantity").to_s.insert(-3, ".")
  end

  def favorite_customer
    customer_id = invoices.joins(:transactions)
      .where("transactions.result = 'success'")
      .group(:customer_id).count
      .sort_by { |id, count| count }.last.first
    Customer.find(customer_id)
  end

  def customers_with_pending_invoices
    customer_ids = invoices.joins(:transactions)
      .where("transactions.result = 'failed'")
      .pluck(:customer_id)
    Customer.where(id: customer_ids)
  end
end
