class Product < ApplicationRecord

  def self.find_by_id(product_id)
    con = PG::Connection.new(dbname: "testapp")
    con.prepare("connection_name", "SELECT * FROM products WHERE id = $1 LIMIT 1")
    product = con.exec_prepared("connection_name", [{ value: product_id}]).to_a[0]
    con.close
    product.symbolize_keys
  end

end
