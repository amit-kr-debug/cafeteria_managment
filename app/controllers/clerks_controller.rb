class ClerksController < ApplicationController
  before_action :ensure_user_is_clerk

  def index
    render "index"
  end

  def pending_orders
    @orders = Order.all
    render "pending_orders"
  end

  def deliver_order
    order = Order.find(params[:order_id])
    order.delivered = true
    order.save
    flash[:success] = "Order delivered!"
    redirect_to clerks_pending_orders_path
  end

  def ensure_user_is_clerk
    if current_user[:user_type] != "clerk"
      redirect_to "/"
    end
  end
end
