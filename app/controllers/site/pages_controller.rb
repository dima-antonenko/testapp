class Site::PagesController < SiteController

  def home
    @products = Orm::Product.get_all_items
    render '/site/home'
  end


end