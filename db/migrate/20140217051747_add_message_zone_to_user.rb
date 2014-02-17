class AddMessageZoneToUser < ActiveRecord::Migration
  def change
    add_column :users, :message_zone, :integer, default: 50
  end
end
