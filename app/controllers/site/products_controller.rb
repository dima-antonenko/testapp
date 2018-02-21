class Site::ProductsController < SiteController

  def show
    @product = Orm::Product.find_by_id(params[:id])
    unless @product 
      render file: "#{Rails.root}/public/404", layout: false, status: :not_found
    end  
  end

  # добавление в корзину зарегистрированным пользователем
  def add_to_cart
    Orm::Cart.add_product(@cart[:id], params[:id])
    redirect_to cart_path(@cart)
  end
    
end
