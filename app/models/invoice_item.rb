class InvoiceItem < ActiveRecord::Base
  belongs_to :item
  belongs_to :invoice
  has_many :transactions, through: :invoice
end
