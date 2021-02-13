class MenusController < ApplicationController
  def index
    @menus = Menu.categorized_menu
    render "all_menus"
  end

  def create
    begin
      menu_id = Menu.maximum("menu_id") + 1
    rescue => exception
      menu_id = 1
    end

    new_menu = Menu.new(
      menu_id: menu_id,
      menu_name: params[:menu_name],
      item_name: params[:item_name],
      price: params[:price],
      description: params[:description],
    )
    if new_menu.save
      redirect_to menus_path
    else
      flash[:error] = new_menu.errors.full_messages.join(", ")
      redirect_to menus_path
    end
  end

  def destroy
    Menu.where(menu_id: params[:id]).destroy_all
    redirect_to menus_path
  end
end
