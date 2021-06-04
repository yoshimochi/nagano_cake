class CreateOrderProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :order_products do |t|
      t.integer :order_id
      t.integer :item_id
      t.integer :tax_included
      t.integer :amount
      t.integer :total_price
      t.integer :making_status, default: 0

      t.timestamps
    end
  end
end
