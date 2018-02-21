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

    # создание заказа если в корзине есть хотя бы 1 товар
    def self.create_order(cart, customer_notice)
      if get_all_items(cart[:id]).size > 0 # если в корзине есть товары то можно создать заказ
        with_connection do |conn|
          conn.prepare("insert_q", "INSERT INTO orders ( customer_id, customer_notice) VALUES ($1, $2) RETURNING id;")
          order_id = conn.exec_prepared("insert_q", [{value: cart[:customer_id]}, {value: customer_notice}]).to_a[0]['id']
          Rails.logger.info "\e[31m order_id: #{order_id} \e[0m  \n \n"
          transfer_cart_items_to_order(cart, order_id) # обновляем у cart_items поле order_id
          remove_cart(cart) # удаление корзины
          order_id
        end
      else
        false
      end
    end

    # получение объектов корзины
    def self.get_all_items(cart_id)
      with_connection do |conn|
        conn.prepare("select_q", "SELECT * FROM cart_products WHERE cart_id =$1 ORDER BY id")
        conn.exec_prepared("select_q", [{value: cart_id}]).to_a
      end
    end

    private

    def self.get_cart_item(cart, cart_item_id)
      with_connection do |conn|
        conn.prepare("select_q", "SELECT * FROM cart_products WHERE cart_id =$1 AND id =$2")
        conn.exec_prepared("select_q", [{value: cart[:id]}, {value: cart_item_id}]).to_a[0]
      end
    end

    def self.remove_cart(cart)
      with_connection do |conn|
        conn.prepare("delete_q", "DELETE FROM carts WHERE id =$1")
        conn.exec_prepared("delete_q", [{value: cart[:id]}])
      end
    end

    def self.transfer_cart_items_to_order(cart, order_id)
      with_connection do |conn|
        conn.prepare("update_q", "UPDATE cart_products SET order_id = $1, cart_id = NULL WHERE cart_id = $2")
        conn.exec_prepared("update_q", [{value: order_id}, {value: cart[:id]}])
      end
    end

    def self.with_connection
      yield conn = PG::Connection.new(dbname: "testapp")
    ensure
      conn.close
    end

  end
end
