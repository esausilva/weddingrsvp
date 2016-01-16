class AddEmailToRsvps < ActiveRecord::Migration
  def change
    add_column :rsvps, :email, :string
  end
end
