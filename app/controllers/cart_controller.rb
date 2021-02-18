class CartController < ApplicationController
  def index
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

  def create
    user = User.find(session[:current_user_id])
    cart = user.cart

    order_hStore = {}
    order_total = 0
    cart.each do |item_id, quantity|
      item = Menu.find(item_id)
      order_total += item.price * quantity.to_i
      order_hStore[item_id] = { "item_name" => item.item_name,
                                "quantity" => quantity,
                                "price" => item.price,
                                "sub_total" => item.price * quantity.to_i }
    end

    new_order = Order.new(
      user_id: user.id,
      order: order_hStore,
      order_date: Date.today,
      delivered: false,
      total: order_total,
    )
    new_order.save

    user.cart = {}
    user.save

    session[:order_placed] = true
    redirect_to customer_orders_path
  end

  def generate_order_hstore(item_id)
    item = Menu.find(item_id)
    { "item_name" => item.name,
      "quantity" => quantity,
      "price" => item.price,
      "sub_total" => item.price * quantity.to_i }
  end
end
