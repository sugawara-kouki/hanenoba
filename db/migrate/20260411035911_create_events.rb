class CreateEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :events do |t|
      t.string :title
      t.references :event_type, null: false, foreign_key: true
      t.integer :capacity
      t.datetime :held_at
      t.string :location
      t.integer :status

      t.timestamps
    end
  end
end
