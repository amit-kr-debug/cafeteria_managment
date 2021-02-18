class OrdersController < ApplicationController
  def index
    @user = User.find(session[:current_user_id])
    @orders = Order.of_user(@user)

    if session[:order_placed] == true
      session[:order_placed] = false
      flash[:success] = "Order Placed!"
      redirect_to customer_orders_path
    else
      render "index"
    end
  end
end
