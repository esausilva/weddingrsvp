class CreateRsvps < ActiveRecord::Migration
  def change
    create_table :rsvps do |t|
      t.string :party
      t.integer :attendees
      t.text :comment
      t.boolean :accept, default: false
      t.boolean :decline, default: false
      t.timestamps
    end
  end
end
