class CreateLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :locations do |t|
      t.string :state
      t.string :region

      t.timestamps
    end
  end
end
