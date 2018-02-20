class AdministratorsController < ApplicationController
  
  before_action :authenticate_administrator!
  protect_from_forgery with: :exception

  layout "administrator"

  def after_sign_in_path_for(resource)
    admnistrator_root_path
  end

  def after_sign_out_path_for(resource_or_scope)
    request.referrer
  end

  def dashboard
    render "/administrators/dashboard"
  end

  
end