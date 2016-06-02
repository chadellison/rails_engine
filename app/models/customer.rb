class Customer < ActiveRecord::Base
  has_many :invoices
  has_many :transactions, through: :invoices #shoulda match
  has_many :merchants, through: :invoices #shoulda match

  def transactions
    Transaction.where(invoice_id: invoices.pluck(:id))
  end

  def favorite_merchant
    binding.pry
    Merchant.includes(:customers)
  end
end

# returns a merchant where the customer has conducted the most successful transactions
