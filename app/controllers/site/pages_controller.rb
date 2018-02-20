class Site::PagesController < SiteController

  def home
    @products = Product.all
    render '/site/home'
  end


end