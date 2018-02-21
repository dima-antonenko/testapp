module Orm
  class ProductCategory

    # получение всех категорий
    def self.get_all_items
      with_connection do |conn|
        conn.prepare("select_q", "SELECT * FROM product_categories ORDER BY id")
        conn.exec_prepared("select_q", []).to_a
      end
    end

    def self.create(parent_id, name)
      parent_category = get_category(parent_id)
      if parent_category
        with_connection do |conn|
          conn.prepare("insert_q", "INSERT INTO product_categories (name, product_category_id) VALUES ($1, $2) ;")
          conn.exec_prepared("insert_q", [{value: name}, {value: parent_id}]).to_a
        end
      else
        false
      end
    end

    def self.get_category(id)
      with_connection do |conn|
        conn.prepare("select_q", "SELECT * FROM product_categories WHERE id =$1")
        conn.exec_prepared("select_q", [{value: id}]).to_a[0]
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
