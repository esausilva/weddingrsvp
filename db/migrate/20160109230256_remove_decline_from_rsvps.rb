class RemoveDeclineFromRsvps < ActiveRecord::Migration
  def change
    remove_column :rsvps, :decline, :boolean
  end
end
