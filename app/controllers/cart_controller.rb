class CartController < ApplicationController
  def index
    @cart = User.cart(session[:current_user_id])
    render "index"
  end

  def update
  end
end
