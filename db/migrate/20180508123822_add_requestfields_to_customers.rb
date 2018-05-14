class AddRequestfieldsToRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :Requests, :confirmed, :boolean, default: false
    add_column :Requests, :accepted, :boolean, default: false
    add_column :Requests, :expired, :boolean, default: false
  end
end
