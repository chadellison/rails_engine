class Merchant < ActiveRecord::Base
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :customers, through: :invoices

  def self.top_revenue(merchant_count)
    joins(:invoice_items)
      .group(:id).order('sum(invoice_items.quantity * invoice_items.unit_price) DESC')
      .limit(merchant_count)
  end

  def total_revenue(date)
    date ? invoices = Invoice.where(created_at: date) : invoices = Invoice
    invoices.joins(:invoice_items, :transactions)
      .where(transactions: {result: "success"})
      .where(merchant_id: id)
      .sum("unit_price * quantity").to_s.insert(-3, ".")
  end

  def favorite_customer
    customers.select("customers.*, count(invoices.customer_id) as inv_count")
      .joins(invoices: :transactions).where("transactions.result = 'success'")
      .group("customers.id").order("inv_count desc").first
  end

  def customers_with_pending_invoices
    customer_ids = invoices.joins(:transactions)
      .where("transactions.result = 'failed'")
      .pluck(:customer_id)
    Customer.where(id: customer_ids)
  end

  def self.rank_by_items(count)
    # sort the merchants by number of items sold in desc order
    # binding.pry
    # grab the first x count of them
    # binding.pry
    # all.sort_by do |m| m.invoice_items.map(&:quantity).reduce(0, :+) end.reverse[0...count.to_i]
    all.sort_by do |m| m.invoice_items.select { |i| i.transactions.all? { |t| t.result == "success" }}.map(&:quantity).reduce(0, :+) end.reverse[0...count.to_i]
  end
end
