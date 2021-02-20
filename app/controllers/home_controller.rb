class HomeController < ApplicationController
  before_action :redirect_to_user_domains
  skip_before_action :ensure_user_logged_in

  def index
    render "index"
  end

  def redirect_to_user_domains
    if current_user != nil
      if current_user[:user_type] == "admin"
        redirect_to dashboard_path
      elsif current_user[:user_type] == "clerk"
        redirect_to clerks_index_path
      elsif current_user[:user_type] == "customer"
        redirect_to customers_path
      end
    end
  end
end
