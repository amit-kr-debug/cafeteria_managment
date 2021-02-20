class SessionsController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def new
    render "signin"
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:current_user_id] = user.id
      session[:user_type] = user.user_type
      session[:order_placed] = false

      if session[:user_type] == "customer"
        redirect_to customers_path
      elsif session[:user_type] == "admin"
        redirect_to dashboard_path
      elsif session[:user_type] == "clerk"
        redirect_to clerks_index_path
      end
    else
      flash[:error] = "Your login attempt was invalid. Please retry!"
      redirect_to new_session_path
    end
  end

  def destroy
    session[:current_user_id] = nil
    @current_user = nil
    redirect_to "/"
  end
end
