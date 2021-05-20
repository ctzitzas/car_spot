class CreateListings < ActiveRecord::Migration[6.1]
  def change
    create_table :listings do |t|
      t.integer :type
      t.integer :status
      t.decimal :price, precision: 10, scale: 2
      t.string :year
      t.string :make
      t.string :model
      t.integer :odometer
      t.string :engine
      t.string :transmission
      t.string :trim
      t.string :body_style
      t.string :registration_number
      t.integer :roadworthy
      t.integer :condition
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
