class AddIndexesToEvents < ActiveRecord::Migration[8.1]
  def change
    add_index :events, :status
    add_index :events, :held_at
  end
end
