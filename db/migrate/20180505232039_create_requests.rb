class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :Requests do |t|
      t.string :name
      t.string :email
      t.integer :phone
      t.text :biography
    end
  end
end
