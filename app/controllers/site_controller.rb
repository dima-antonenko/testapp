class SiteController < ApplicationController

  before_action :all_pages_data

  def all_pages_data
    @cart = Cart.get_current_customer_cart(current_customer.id) if current_customer
    @cart = nil unless current_customer
  end


end
