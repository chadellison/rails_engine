class Customer < ActiveRecord::Base
  has_many :invoices

  def transactions
    Transaction.where(invoice_id: invoices.pluck(:id))
  end
end
