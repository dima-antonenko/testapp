module Orm
  class Cart

    # удаляет товар из корзины
    # возвращает nil если запись не найдена или запись пренадлежит к другой корзине  
    def self.remove_item(cart, item_id)
      cart_item = get_cart_item(cart, item_id) # {"id"=>"6", "product_id"=>"1", "cart_id"=>"12", "order_id"=>nil, "product_price"=>"100", "product_qty"=>"12", "product_total_price"=>"1200"}
      if cart_item
        with_connection do |conn|
          conn.prepare("delete_q", "DELETE FROM cart_products WHERE id =$1")
          conn.exec_prepared("delete_q", [{value: item_id}]).to_a[0]
        end
      end
    end

    private

    def self.get_cart_item(cart, cart_item_id)
      with_connection do |conn|
        conn.prepare("select_q", "SELECT * FROM cart_products WHERE cart_id =$1 AND id =$2")
        conn.exec_prepared("select_q", [{value: cart[:id]}, {value: cart_item_id}]).to_a[0]
      end
    end

    def self.with_connection
      yield conn = PG::Connection.new(dbname: "testapp")
    ensure
      conn.close
    end

  end
end
