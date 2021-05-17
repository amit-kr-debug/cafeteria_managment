class MenusController < AdminController
  def index
    @menus = Menu.all
    render "all_menus"
  end

  def create
    new_menu = Menu.new(
      name: params[:menu_name],
    )
    if new_menu.save
      redirect_to menus_path
    else
      flash[:error] = new_menu.errors.full_messages.join(", ")
      redirect_to menus_path
    end
  end

  def destroy
    Menu.find(params[:id]).destroy
    redirect_to menus_path
  end

  def update
    id = params[:id]
    active = params[:active]
    Menu.set_active(id)
    redirect_to menus_path
  end
end
