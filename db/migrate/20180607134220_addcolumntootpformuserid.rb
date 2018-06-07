class Addcolumntootpformuserid < ActiveRecord::Migration[5.2]
  def change
    add_column :otpforms,:user_id,:integer
  end
end