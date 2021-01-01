require "application_system_test_case"

class OutdoorLevelsTest < ApplicationSystemTestCase
  setup do
    @outdoor_level = outdoor_levels(:one)
  end

  test "visiting the index" do
    visit outdoor_levels_url
    assert_selector "h1", text: "Outdoor Levels"
  end

  test "creating a Outdoor level" do
    visit outdoor_levels_url
    click_on "New Outdoor Level"

    fill_in "Level", with: @outdoor_level.level
    click_on "Create Outdoor level"

    assert_text "Outdoor level was successfully created"
    click_on "Back"
  end

  test "updating a Outdoor level" do
    visit outdoor_levels_url
    click_on "Edit", match: :first

    fill_in "Level", with: @outdoor_level.level
    click_on "Update Outdoor level"

    assert_text "Outdoor level was successfully updated"
    click_on "Back"
  end

  test "destroying a Outdoor level" do
    visit outdoor_levels_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Outdoor level was successfully destroyed"
  end
end
