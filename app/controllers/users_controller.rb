class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def signup
    render "signup"
  end

  def create
    name = params[:name]
    email = params[:email]
    password = params[:password]
    user = User.new(
      name: name,
      email: email,
      password: password,
      user_type: "customer",
      cart: {},
    )
    begin
      user.save!
      session[:current_user_id] = user.id
      redirect_to "/"
    rescue
      flash[:error] = "Email is already registered! Please signin"
      redirect_to sign_up_path
    end
  end
end
