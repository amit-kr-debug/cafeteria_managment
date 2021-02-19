class ClerksController < ApplicationController
  def index
    render "index"
  end

  def pending_orders
    @orders = Order.all
    render "pending_orders"
  end
end
