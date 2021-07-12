class CreateNotable < ActiveRecord::Migration[6.1]
  def change
    create_table :notables do |t|
      t.integer :capacity
      t.timestamps
    end
  end
end
