require 'csv'

desc "Import merchants from csv"
task import: :environment do
  filename = "data/merchants.csv"
  CSV.foreach(filename, headers: true, header_converters: :symbol) do |row|
    merchant = Merchant.create(row.to_h)
  end

  filename = "data/items.csv"
  CSV.foreach(filename, headers: true, header_converters: :symbol) do |row|
    item = Item.create(row.to_h)
  end

  filename = "data/customers.csv"
  CSV.foreach(filename, headers: true, header_converters: :symbol) do |row|
    customer = Customer.create(row.to_h)
  end

  filename = "data/transactions.csv"
  CSV.foreach(filename, headers: true, header_converters: :symbol) do |row|
    transaction = Transaction.create(row.to_h)
  end

  filename = "data/invoices.csv"
  CSV.foreach(filename, headers: true, header_converters: :symbol) do |row|
    invoice = Invoice.create(row.to_h)
  end

  filename = "data/invoice_items.csv"

  CSV.foreach(filename, headers: true, header_converters: :symbol) do |row|
    invoice_item = InvoiceItem.create(row.to_h)
  end
end
