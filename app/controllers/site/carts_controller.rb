class Site::CartsController < SiteController

  def show
    @items = Cart.get_all_items(@cart[:id])
  end

end  