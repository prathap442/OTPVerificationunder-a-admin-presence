require "application_system_test_case"

class OtpformsTest < ApplicationSystemTestCase
  setup do
    @otpform = otpforms(:one)
  end

  test "visiting the index" do
    visit otpforms_url
    assert_selector "h1", text: "Otpforms"
  end

  test "creating a Otpform" do
    visit otpforms_url
    click_on "New Otpform"

    fill_in "Mobile", with: @otpform.mobile
    fill_in "Otp Recived", with: @otpform.otp_recived
    click_on "Create Otpform"

    assert_text "Otpform was successfully created"
    click_on "Back"
  end

  test "updating a Otpform" do
    visit otpforms_url
    click_on "Edit", match: :first

    fill_in "Mobile", with: @otpform.mobile
    fill_in "Otp Recived", with: @otpform.otp_recived
    click_on "Update Otpform"

    assert_text "Otpform was successfully updated"
    click_on "Back"
  end

  test "destroying a Otpform" do
    visit otpforms_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Otpform was successfully destroyed"
  end
end
