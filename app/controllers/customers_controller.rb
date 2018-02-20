class CustomersController < ApplicationController

  before_action :authenticate_customer!
  protect_from_forgery with: :exception

  layout "customer"

  def after_sign_in_path_for(resource)
    customer_root_path
  end

  def after_sign_out_path_for(resource_or_scope)
    request.referrer
  end

  def dashboard
    render "layouts/customer/dashboard"
  end


end
