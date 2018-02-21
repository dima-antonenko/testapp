module Orm
  class Cart < Orm::Base

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
     # all_items = get_all_items(cart[:id]).to_a
     # Rails.logger.info "\e[31m all_items: #{all_items} \e[0m  \n \n"
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

    # получаем корзину текущего покупателя
    def self.get_current_customer_cart(current_customer_id)
      with_connection do |conn|
        conn.prepare("select_q", 'SELECT * FROM carts WHERE customer_id = $1 LIMIT 1')
        cart = conn.exec_prepared("select_q", [{ value: current_customer_id}]).to_a[0]

        unless cart # если корзины нету -> создаем ее и возвращаем в виде {"id"=>"1", "customer_id"=>"1"}
          conn.prepare("insert_q", 'INSERT INTO carts (customer_id) SELECT ($1)')
          conn.exec_prepared("insert_q", [{ value: current_customer_id}])
          cart = conn.exec_prepared("select_q", [{ value: current_customer_id}]).to_a[0]
        end
        cart = cart.symbolize_keys
      end
    end

    # добавление товара в корзину
    def self.add_product(cart_id, product_id)
      with_connection do |conn|
        conn.prepare("select_q", "SELECT * FROM cart_products WHERE cart_id =$1 AND product_id =$2 LIMIT 1")
        product_item = conn.exec_prepared("select_q", [{ value: cart_id}, {value: product_id}]).to_a[0] # {"id"=>"5", "product_id"=>"1", "cart_id"=>"12", "order_id"=>nil, "product_price"=>"100", "product_qty"=>"1", "product_total_price"=>"100"}
        product_item ? update_product_in_cart(product_item) : add_new_product_to_cart(cart_id, product_id)
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

    # добавляем новый товар в корзину
    def self.add_new_product_to_cart(cart_id, product_id)
      with_connection do |conn|
        conn.prepare("product_q", "SELECT * FROM products WHERE id = $1 LIMIT 1")
        product = conn.exec_prepared("product_q", [{ value: product_id}]).to_a[0]
        product = product.symbolize_keys if product
        if product
          conn.prepare("cart_prod_q", "INSERT INTO cart_products ( cart_id, product_id, product_price, product_qty, product_total_price) VALUES ($1, $2, $3, $4, $5);")
          conn.exec_prepared("cart_prod_q", [{value: cart_id}, {value: product_id}, {value: product[:price]}, {value: 1}, {value: product[:price]}])
        end
      end
    end

    # обновляем товар в корзине
    def self.update_product_in_cart(product_item)
      with_connection do |conn|
        product_item = product_item.symbolize_keys # {"id"=>"5", "product_id"=>"1", "cart_id"=>"12", "order_id"=>nil, "product_price"=>"100", "product_qty"=>"1", "product_total_price"=>"100"}
        conn.prepare("product_item_q", "UPDATE cart_products SET product_qty = $1, product_total_price = $2 WHERE id = $3")
        conn.exec_prepared("product_item_q", [{value: inc_qty(product_item[:product_qty])}, {value: calc_total_price(product_item)}, {value: product_item[:id]}])
      end
    end

    def self.inc_qty(qty)
      qty = qty.to_i
      qty += 1
    end

    def self.calc_total_price(product_item)
      inc_qty(product_item[:product_qty]) * product_item[:product_price].to_i
    end

    
  end
end
