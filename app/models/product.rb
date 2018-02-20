class Product < ApplicationRecord

  # возвращает nil или {"id"=>1, "name"=>"тестовый товар №0", "price"=>100, "product_category_id"=>1}
  def self.find_by_id(product_id)
    product = ActiveRecord::Base.connection.execute("SELECT * FROM products WHERE id = #{product_id} LIMIT 1").to_a[0]  
  end

end
