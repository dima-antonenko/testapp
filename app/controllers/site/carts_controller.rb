class Site::CartsController < SiteController

  def show
    @items = Orm::Cart.get_all_items(@cart[:id])
    @new_order = Order.new
  end

  def remove_item
    result = Orm::Cart.remove_item(@cart, params[:id])
    redirect_to cart_path(@cart)
  end

end  