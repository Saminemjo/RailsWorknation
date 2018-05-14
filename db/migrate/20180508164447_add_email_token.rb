class AddEmailToken < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :confirm_token, :string
  end
end
