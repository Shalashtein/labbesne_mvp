require "application_system_test_case"

class SocialActivitiesTest < ApplicationSystemTestCase
  setup do
    @social_activity = social_activities(:one)
  end

  test "visiting the index" do
    visit social_activities_url
    assert_selector "h1", text: "Social Activities"
  end

  test "creating a Social activity" do
    visit social_activities_url
    click_on "New Social Activity"

    fill_in "Name", with: @social_activity.name
    click_on "Create Social activity"

    assert_text "Social activity was successfully created"
    click_on "Back"
  end

  test "updating a Social activity" do
    visit social_activities_url
    click_on "Edit", match: :first

    fill_in "Name", with: @social_activity.name
    click_on "Update Social activity"

    assert_text "Social activity was successfully updated"
    click_on "Back"
  end

  test "destroying a Social activity" do
    visit social_activities_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Social activity was successfully destroyed"
  end
end
