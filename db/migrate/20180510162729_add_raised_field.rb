class AddRaisedField < ActiveRecord::Migration[5.2]
  def change
      add_column :requests, :raised_at, :datetime
  end
end
