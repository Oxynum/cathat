class AddConnectedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :connected, :boolean, default: false, null: false
  end
end
