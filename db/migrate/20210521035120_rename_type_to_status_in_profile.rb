class RenameTypeToStatusInProfile < ActiveRecord::Migration[6.1]
  def change
    rename_column :profiles, :type, :status
  end
end
