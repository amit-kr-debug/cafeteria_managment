class ItemsController < ApplicationController
  def index
    @menu = Menu.of_menu(params["menu_id"])
    render "menu_items"
  end

  def destroy
    Menu.find(params[:id]).destroy
    redirect_to menu_items_path
  end

  def create
    menu_id = params["menu_id"]
    menu = Menu.of_menu(menu_id)[0]
    new_item = Menu.new(
      menu_id: params["menu_id"],
      menu_name: menu.menu_name,
      item_name: params[:item_name],
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
