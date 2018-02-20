class CreateCartProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :cart_products do |t|
      t.integer :product_id, index: true
      t.integer :cart_id, index: true
      t.integer :order_id, index: true

      t.integer :product_price, index: true
      t.integer :product_qty, index: true, default: 1
      t.integer :product_total_price, index: true

      t.timestamps
    end
  end
end
