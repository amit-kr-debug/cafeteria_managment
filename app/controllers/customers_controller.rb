class CustomersController < ApplicationController
  def index
    @menu = Menu.active
    @user = User.details(session[:current_user_id])
    render "index"
  end

  def update
    user = User.find(session[:current_user_id])
    cart = user.cart
    if cart == nil
      user.cart = { params[:id] => params[:quantity] }
    else
      if params[:quantity] == "0"
        cart.delete(params[:id])
      else
        cart[params[:id]] = params[:quantity]
      end
    end
    user.save!
    redirect_to customers_path
  end
end
