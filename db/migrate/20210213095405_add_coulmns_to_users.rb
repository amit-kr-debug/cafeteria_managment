class AddCoulmnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :cart, :hstore
  end
end
