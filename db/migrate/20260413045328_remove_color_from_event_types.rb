class RemoveColorFromEventTypes < ActiveRecord::Migration[8.1]
  def change
    remove_column :event_types, :color, :string
  end
end
