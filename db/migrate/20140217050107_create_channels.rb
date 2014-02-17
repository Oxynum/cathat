class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :title
      t.float :latitude
      t.float :longitude
      t.references :creator

      t.timestamps
    end
  end
end
