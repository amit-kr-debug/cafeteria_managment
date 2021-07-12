class EditusersController < AdminController
  def index
    @admins = User.admins
    @clerks = User.clerks
    @customers = User.customers
    render "index"
  end

  def destroy
    user = User.find(params[:id])
    if user.user_type == "customer"
      orders = Order.of_user(user)
      orders.each { |order| order.destroy }
    end
    user.destroy
    redirect_to editusers_path
  end

  def create
    name = params[:name]
    email = params[:email]
    password = params[:password]
    user_type = params[:user_type]
    user = User.new(
      name: name,
      email: email,
      password: password,
      user_type: user_type,
      cart: {},
    )
    if user.save
      redirect_to editusers_path
    else
      flash[:error] = user.errors.full_messages.join(", ")
      redirect_to new_user_path
    end
  end
end
