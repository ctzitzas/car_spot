class RenameTypeToAdtypeInListings < ActiveRecord::Migration[6.1]
  def change
    rename_column :listings, :type, :ad_type
  end
end
