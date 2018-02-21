class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id, index: true
      t.text :customer_notice, index: true
    end
  end
end
