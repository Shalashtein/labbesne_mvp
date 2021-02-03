require "application_system_test_case"

class PreregistrationsTest < ApplicationSystemTestCase
  setup do
    @preregistration = preregistrations(:one)
  end

  test "visiting the index" do
    visit preregistrations_url
    assert_selector "h1", text: "Preregistrations"
  end

  test "creating a Preregistration" do
    visit preregistrations_url
    click_on "New Preregistration"

    fill_in "Email", with: @preregistration.email
    click_on "Create Preregistration"

    assert_text "Preregistration was successfully created"
    click_on "Back"
  end

  test "updating a Preregistration" do
    visit preregistrations_url
    click_on "Edit", match: :first

    fill_in "Email", with: @preregistration.email
    click_on "Update Preregistration"

    assert_text "Preregistration was successfully updated"
    click_on "Back"
  end

  test "destroying a Preregistration" do
    visit preregistrations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Preregistration was successfully destroyed"
  end
end
