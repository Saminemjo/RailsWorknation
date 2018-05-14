class RenameConfirmedField < ActiveRecord::Migration[5.2]
  def change
    rename_column :requests, :confirmed, :email_confirmed
  end
end
