class SessionsController < ApplicationController
  def new
    render "signin"
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:current_user_id] = user.id
      redirect_to "/"
    else
      flash[:error] = "Your login attempt was invalid. Please retry!"
      redirect_to new_session_path
    end
  end
end
