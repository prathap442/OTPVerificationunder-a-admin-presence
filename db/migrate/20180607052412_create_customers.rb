class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :mobile
      t.string :otpsent
      t.boolean :verified 
      t.timestamps
    end
  end
end
