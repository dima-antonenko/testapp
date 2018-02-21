class Administrators::ProductCategoriesController < AdministratorsController

  def index
    @all_categories = Orm::ProductCategory.get_all_items
  end

  def add_children
    @new_category = ProductCategory.new
    @parent_id = params[:id]
  end

  def create
    cat_params = params.require(:product_category)
    Orm::ProductCategory.create(cat_params[:parent_id], cat_params[:name])
    redirect_to administrators_product_categories_path
  end

  def add_product
    
  end

end  