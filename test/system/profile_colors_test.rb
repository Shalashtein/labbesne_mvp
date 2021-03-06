require "application_system_test_case"

class ProfileColorsTest < ApplicationSystemTestCase
  setup do
    @profile_color = profile_colors(:one)
  end

  test "visiting the index" do
    visit profile_colors_url
    assert_selector "h1", text: "Profile Colors"
  end

  test "creating a Profile color" do
    visit profile_colors_url
    click_on "New Profile Color"

    fill_in "Color", with: @profile_color.color
    fill_in "Profile", with: @profile_color.profile_id
    click_on "Create Profile color"

    assert_text "Profile color was successfully created"
    click_on "Back"
  end

  test "updating a Profile color" do
    visit profile_colors_url
    click_on "Edit", match: :first

    fill_in "Color", with: @profile_color.color
    fill_in "Profile", with: @profile_color.profile_id
    click_on "Update Profile color"

    assert_text "Profile color was successfully updated"
    click_on "Back"
  end

  test "destroying a Profile color" do
    visit profile_colors_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Profile color was successfully destroyed"
  end
end
