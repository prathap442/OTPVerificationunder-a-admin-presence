json.extract! otpform, :id, :mobile, :otp_received, :created_at, :updated_at
json.url otpform_url(otpform, format: :json)
