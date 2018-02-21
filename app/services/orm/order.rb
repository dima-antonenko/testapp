module Orm
  class Order

    def self.get_all_items
      with_connection do |conn|
        conn.prepare("select_q", "SELECT * FROM orders ORDER BY id")
        conn.exec_prepared("select_q", []).to_a
      end
    end

    def self.get_item(id)
       with_connection do |conn|
        conn.prepare("select_q", "SELECT * FROM orders WHERE id =$1")
        conn.exec_prepared("select_q", [{value: id}]).to_a[0].symbolize_keys
       end 
    end

    def self.get_order_product_items(id)
      with_connection do |conn|
        conn.prepare("select_q", "SELECT  product_id, name, order_id,  product_price, product_qty, product_total_price FROM cart_products 
                                  LEFT JOIN products 
                                  ON cart_products.product_id = products.id
                                  where order_id = $1")
        conn.exec_prepared("select_q", [{value: id}]).to_a
       end
    end

    private

    def self.with_connection
      yield conn = PG::Connection.new(dbname: "testapp")
    ensure
      conn.close
    end

  end
end
