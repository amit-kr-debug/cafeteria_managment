class UsersController < ApplicationController
  def new
    render "users/new"
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
    )
    if user.save
      session[:current_user_id] = user.id
      redirect_to "/"
    else
      flash[:error] = user.errors.full_messages.join(", ")
      redirect_to new_user_path
    end
  end
end
