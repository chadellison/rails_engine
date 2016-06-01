class Merchant < ActiveRecord::Base
  has_many :items
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
end
