class CreateProductCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :product_categories do |t|
      t.string  :name, index: true
      t.integer :product_category_id, index: true, null: false
      t.boolean :is_root, index: true, default: false
    end
  end
end
