class CartController < ApplicationController
  def index
    @available_tables = Allocation.available_tables()
    puts @available_tables
    @next_available_time = 0
    if @available_tables == 0
      @next_available_time = Allocation.next_available_time()
    end
    @cart = User.cart(session[:current_user_id])
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
    redirect_to customer_cart_index_path
  end

  def destroy
    user = User.find(session[:current_user_id])
    cart = user.cart
    cart.delete(params[:id])
    user.save
    redirect_to customer_cart_index_path
  end

  def create
    user = User.find(session[:current_user_id])
    cart = user.cart
    if cart.length > 0
      order_hStore = {}
      order_total = 0
      cart.each do |item_id, quantity|
        item = Item.find(item_id)
        order_total += item.price * quantity.to_i
        order_hStore[item_id] = { "item_name" => item.name,
                                  "quantity" => quantity,
                                  "price" => item.price,
                                  "sub_total" => item.price * quantity.to_i }
      end
      is_dine_in = false
      allocated_table = nil
      time = nil
      if params[:is_dine_in] == "true"
        is_dine_in = true
        allocated_table = Allocation.allocate_table(user.id)
        time = Allocation.getTimeof(allocated_table)
      end
      if session[:user_type] == "clerk"
        walk_in_customer = User.where(name: "Walk-in")[0]
        new_order = Order.new(
          user_id: walk_in_customer.id,
          order: order_hStore,
          order_date: Date.today,
          delivered: false,
          total: order_total,
          is_dine_in: is_dine_in,
          allocated_table: allocated_table,
          time: time,
        )
      else
        new_order = Order.new(
          user_id: user.id,
          order: order_hStore,
          order_date: Date.today,
          delivered: false,
          total: order_total,
          is_dine_in: is_dine_in,
          allocated_table: allocated_table,
          time: time,
        )
      end

      new_order.save
      user.cart = {}
      user.save
      session[:order_placed] = true




      if session[:user_type] == "clerk"
        redirect_to clerks_pending_orders_path
      elsif session[:order_placed]
        session[:order_placed] = false
        if is_dine_in
          flash[:success] = "Order Placed! Your alloted table number is #{allocated_table}"
          redirect_to customer_orders_path
        else
          flash[:success] = "Order placed"
          redirect_to customer_orders_path
        end
      else
        flash[:error]="Order not placed"
        redirect_to customers_path
      end
    else
      redirect_to customers_path
    end
  end
end
