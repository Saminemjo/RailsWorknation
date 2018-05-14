class AddTimestamps < ActiveRecord::Migration[5.2]
  def change
    change_table :Requests do |t|
      t.timestamps
    end
  end
end
