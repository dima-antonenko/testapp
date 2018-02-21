class Administrators::OrdersController < AdministratorsController

  def index
    @orders = Orm::Order.get_all_items
  end

  def show
    @order = Orm::Order.get_item(params[:id])
    @product_items = Orm::Order.get_order_product_items(params[:id])
  end

end  