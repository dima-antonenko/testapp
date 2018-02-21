class Administrators::ProductsController < AdministratorsController

  def create
    prod_params = params.require(:product)
    result = Orm::ProductCategory.add_product(prod_params[:parent_id], prod_params[:name], prod_params[:price])
     Rails.logger.error "\e[31m result: #{result} \n \n \e[0m"
    if result
      redirect_to product_path(result)
    else
      redirect_to administrators_product_categories_path
    end
  end

end
