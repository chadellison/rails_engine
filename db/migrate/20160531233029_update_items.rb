class UpdateItems < ActiveRecord::Migration
  def change
    change_table :items do |t|
      t.remove :unit_price
      t.remove :merchant_id
      t.integer :unit_price
      t.integer :merchant_id
    end
  end
end
