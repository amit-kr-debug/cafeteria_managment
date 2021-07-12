class OrdersController < ApplicationController
  def index
    @user = User.find(session[:current_user_id])
    @orders = Order.of_user(@user)
    render "index"
  end
end
