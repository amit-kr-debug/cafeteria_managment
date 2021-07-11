class CreateAllocations < ActiveRecord::Migration[6.1]
  def change
    create_table :allocations do |t|
      t.datetime :time
      t.integer :user_id
      t.timestamps
    end
  end
end
