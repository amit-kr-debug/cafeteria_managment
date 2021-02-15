class CreateOrder < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.hstore :order
      t.date :order_date
      t.boolean :delivered

      t.timestamps
    end
  end
end
