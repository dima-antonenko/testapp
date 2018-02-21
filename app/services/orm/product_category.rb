module Orm
  class ProductCategory

    # получение всех категорий
    def self.get_all_items
      with_connection do |conn|
        query = "WITH RECURSIVE tree AS (
                 SELECT
                   id, name, product_category_id, name AS sort_string, 1 AS depth
                 FROM product_categories
                 WHERE is_root = true
                 UNION ALL
                 SELECT
                 s1.id, s1.name, s1.product_category_id,
                 tree.sort_string || ' -> ' || s1.name AS sort_string, tree.depth+1 AS depth
                 FROM tree
                 JOIN product_categories s1 ON s1.product_category_id = tree.id)
                 SELECT depth, name, id, product_category_id, sort_string FROM tree ORDER BY sort_string ASC;"
        conn.prepare("select_q", query)
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
