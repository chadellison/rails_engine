class Customer < ActiveRecord::Base
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices

  def transactions
    Transaction.where(invoice_id: invoices.pluck(:id))
  end

  def favorite_merchant
    merchants.select("merchants.*, count(invoices.merchant_id) as inv_count")
      .joins(invoices: :transactions).where("transactions.result = 'success'")
      .group("merchants.id")
      .order("inv_count desc")
      .first
  end
end
