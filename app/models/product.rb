class Product < ApplicationRecord

  def self.find_by_id(product_id)
    product = ActiveRecord::Base.connection.execute("SELECT * FROM products WHERE id = #{product_id} LIMIT 1").to_a[0]
    unless product
      # выдать исключение
    end  
  end

end
