class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string  :name, index: true
      t.integer :price, index: true
      t.integer :product_category_id, index: true
    end
  end
end
