class DeleteAllOrder < ActiveRecord::Migration[6.1]
  def change
    Order.delete_all
  end
end
