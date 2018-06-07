require 'test_helper'

class OtpformsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @otpform = otpforms(:one)
  end

  test "should get index" do
    get otpforms_url
    assert_response :success
  end

  test "should get new" do
    get new_otpform_url
    assert_response :success
  end

  test "should create otpform" do
    assert_difference('Otpform.count') do
      post otpforms_url, params: { otpform: { mobile: @otpform.mobile, otp_recived: @otpform.otp_recived } }
    end

    assert_redirected_to otpform_url(Otpform.last)
  end

  test "should show otpform" do
    get otpform_url(@otpform)
    assert_response :success
  end

  test "should get edit" do
    get edit_otpform_url(@otpform)
    assert_response :success
  end

  test "should update otpform" do
    patch otpform_url(@otpform), params: { otpform: { mobile: @otpform.mobile, otp_recived: @otpform.otp_recived } }
    assert_redirected_to otpform_url(@otpform)
  end

  test "should destroy otpform" do
    assert_difference('Otpform.count', -1) do
      delete otpform_url(@otpform)
    end

    assert_redirected_to otpforms_url
  end
end
