class RenameOldTabletoNewTable < ActiveRecord::Migration[5.2]
  def change
    rename_table :Requests, :requests
  end
end
