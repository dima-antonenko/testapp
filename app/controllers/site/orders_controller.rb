class Site::OrdersController < SiteController

  def create
    result = Orm::Cart.create_order(@cart, params[:order][:customer_notice])
    if result
      redirect_to root_path, notice: 'Заказ оформлен, спасибо'
    else
      redirect_back(fallback_location: cart_path(@cart))
    end
  end



end
