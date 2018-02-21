class Cart < ApplicationRecord

  # получаем корзину для текущего покупателя
  def self.get_current_customer_cart(current_customer_id)
    con = PG::Connection.new(dbname: "testapp")
    con.prepare("select_q", 'SELECT * FROM carts WHERE customer_id = $1 LIMIT 1')
    cart = con.exec_prepared("select_q", [{ value: current_customer_id}]).to_a[0]

    unless cart # если корзины нету -> создаем ее и возвращаем в виде {"id"=>"1", "customer_id"=>"1"}
      con.prepare("insert_q", 'INSERT INTO carts (customer_id) SELECT ($1)')
      con.exec_prepared("insert_q", [{ value: current_customer_id}])
      cart = con.exec_prepared("select_q", [{ value: current_customer_id}]).to_a[0]
    end
    con.close
    cart.symbolize_keys
  end

  # добавление товара в корзину
  def self.add_product(cart_id, product_id)
    con = PG::Connection.new(dbname: "testapp")
    con.prepare("select_q", "SELECT * FROM cart_products WHERE cart_id =$1 AND product_id =$2 LIMIT 1")
    product_item = con.exec_prepared("select_q", [{ value: cart_id}, {value: product_id}]).to_a[0] # {"id"=>"5", "product_id"=>"1", "cart_id"=>"12", "order_id"=>nil, "product_price"=>"100", "product_qty"=>"1", "product_total_price"=>"100"}
    con.close
    product_item ? update_product_in_cart(product_item) : add_new_product_to_cart(cart_id, product_id)
    #add_new_product_to_cart(cart_id, product_id)
  end

  # просмотр всех товаров в корзине
  def self.get_all_items(cart_id)
    con = PG::Connection.new(dbname: "testapp")
    con.prepare("select_q", "SELECT * FROM cart_products WHERE cart_id =$1 ORDER BY id")
    cart_items = con.exec_prepared("select_q", [{value: cart_id}])
    con.close
    cart_items
  end

  private

  # добавляем новый товар в корзину
  def self.add_new_product_to_cart(cart_id, product_id)
    con = PG::Connection.new(dbname: "testapp")
    con.prepare("product_q", "SELECT * FROM products WHERE id = $1 LIMIT 1")
    product = con.exec_prepared("product_q", [{ value: product_id}]).to_a[0]
    product = product.symbolize_keys if product
    if product
      con.prepare("cart_prod_q", "INSERT INTO cart_products ( cart_id, product_id, product_price, product_qty, product_total_price) VALUES ($1, $2, $3, $4, $5);")
      con.exec_prepared("cart_prod_q", [{value: cart_id}, {value: product_id}, {value: product[:price]}, {value: 1}, {value: product[:price]}])
    end
    con.close
  end

  # обновляем товар в корзине
  def self.update_product_in_cart(product_item)
    product_item = product_item.symbolize_keys # {"id"=>"5", "product_id"=>"1", "cart_id"=>"12", "order_id"=>nil, "product_price"=>"100", "product_qty"=>"1", "product_total_price"=>"100"}
    con = PG::Connection.new(dbname: "testapp")
    con.prepare("product_item_q", "UPDATE cart_products SET product_qty = $1, product_total_price = $2 WHERE id = $3")
    con.exec_prepared("product_item_q", [{value: inc_qty(product_item[:product_qty])}, {value: calc_total_price(product_item)}, {value: product_item[:id]}])
    con.close
  end

  def self.inc_qty(qty)
    qty = qty.to_i
    qty += 1
  end

  def self.calc_total_price(product_item)
    inc_qty(product_item[:product_qty]) * product_item[:product_price].to_i
  end


end
