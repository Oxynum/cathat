class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :body
      t.float :latitude
      t.float :longitude
      t.references :author
      t.references :channel

      t.timestamps
    end
  end
end
