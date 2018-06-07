class CreateOtpforms < ActiveRecord::Migration[5.2]
  def change
    create_table :otpforms do |t|
      t.string :mobile
      t.string :otp_received

      t.timestamps
    end
  end
end
