class AdminController < ApplicationController
  def dashboard
    render "dashboard"
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
    if session[:user_type] == "admin"
      redirect_to pending_orders_path
    else
      redirect_to clerks_pending_orders_path
    end
  end

  def records_get
    records = []
    render "records"
  end

  def records_post
    lower_date_limit = params[:lower_date_limit]
    upper_date_limit = params[:upper_date_limit]
    @records = Order.records(lower_date_limit, upper_date_limit)
    render "records"
  end

  def view_particular_order
    @order = Order.where(id: params[:order_id])
    render "invoice"
  end
end
