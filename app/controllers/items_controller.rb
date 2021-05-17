class ItemsController < AdminController
  def index
    @menu = Menu.find(params["menu_id"])
    @items = Item.of_menu(params["menu_id"])
    render "menu_items"
  end

  def destroy
    Item.find(params[:id]).destroy
    redirect_to menu_items_path
  end

  def update
    item = Item.find(params[:id])
    item.name = params["name"]
    item.description = params["description"]
    item.price = params["price"]
    item.save
    redirect_to menu_items_path
  end

  def create
    menu_id = params["menu_id"]
    new_item = Item.new(
      menu_id: params["menu_id"],
      name: params[:item_name],
      price: params[:price],
      description: params[:description],
    )
    if new_item.save
      redirect_to menu_items_path
    else
      flash[:error] = new_menu.errors.full_messages.join(", ")
      redirect_to menu_items_path
    end
  end
end
