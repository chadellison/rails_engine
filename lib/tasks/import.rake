require 'csv'

description "Import merchants from csv"
task import: [:environment] do
  filename = "data/merchants.csv"

  CSV.foreach(filename, headers: true, header_converters: :symbol) do |row|
    merchant = Merchant.create(id: row[:id],
                               name: row[:name],
                               created_at: row[:created_at],
                               updated_at: row[:updated_at])
    end
  end
