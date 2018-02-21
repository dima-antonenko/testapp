module Orm
  class Base

    def self.with_connection
      yield conn = PG::Connection.new(dbname: "testapp")
    ensure
      conn.close
    end

  end  
end