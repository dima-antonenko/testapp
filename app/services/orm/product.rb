module Orm
  class Product < Orm::Base

    def self.find_by_id(product_id)
      with_connection do |conn|
        conn.prepare("select_q", "SELECT * FROM products WHERE id = $1 LIMIT 1")
        product = conn.exec_prepared("select_q", [{ value: product_id}]).to_a[0]
        product.symbolize_keys
      end
    end

    def self.get_all_items
      with_connection do |conn|
        conn.prepare("select_q", "SELECT * FROM products")
        conn.exec_prepared("select_q", []).to_a
      end
    end

  end
end
