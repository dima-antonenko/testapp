class Site::ProductsController < SiteController

  def show
    @product = Product.find_by_id(params[:id])
    unless @product 
      render file: "#{Rails.root}/public/404", layout: false, status: :not_found
    end  
  end
    
end
