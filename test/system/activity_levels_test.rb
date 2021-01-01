require "application_system_test_case"

class ActivityLevelsTest < ApplicationSystemTestCase
  setup do
    @activity_level = activity_levels(:one)
  end

  test "visiting the index" do
    visit activity_levels_url
    assert_selector "h1", text: "Activity Levels"
  end

  test "creating a Activity level" do
    visit activity_levels_url
    click_on "New Activity Level"

    fill_in "Name", with: @activity_level.name
    click_on "Create Activity level"

    assert_text "Activity level was successfully created"
    click_on "Back"
  end

  test "updating a Activity level" do
    visit activity_levels_url
    click_on "Edit", match: :first

    fill_in "Name", with: @activity_level.name
    click_on "Update Activity level"

    assert_text "Activity level was successfully updated"
    click_on "Back"
  end

  test "destroying a Activity level" do
    visit activity_levels_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Activity level was successfully destroyed"
  end
end
