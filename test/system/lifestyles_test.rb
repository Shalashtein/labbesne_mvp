require "application_system_test_case"

class LifestylesTest < ApplicationSystemTestCase
  setup do
    @lifestyle = lifestyles(:one)
  end

  test "visiting the index" do
    visit lifestyles_url
    assert_selector "h1", text: "Lifestyles"
  end

  test "creating a Lifestyle" do
    visit lifestyles_url
    click_on "New Lifestyle"

    fill_in "Activity levels", with: @lifestyle.activity_levels_id
    fill_in "Job types", with: @lifestyle.job_types_id
    fill_in "Outdoor levels", with: @lifestyle.outdoor_levels_id
    fill_in "Profiles", with: @lifestyle.profiles_id
    fill_in "Social activities", with: @lifestyle.social_activities_id
    check "Studies" if @lifestyle.studies
    fill_in "Study hours", with: @lifestyle.study_hours
    fill_in "Work hours", with: @lifestyle.work_hours
    check "Works" if @lifestyle.works
    click_on "Create Lifestyle"

    assert_text "Lifestyle was successfully created"
    click_on "Back"
  end

  test "updating a Lifestyle" do
    visit lifestyles_url
    click_on "Edit", match: :first

    fill_in "Activity levels", with: @lifestyle.activity_levels_id
    fill_in "Job types", with: @lifestyle.job_types_id
    fill_in "Outdoor levels", with: @lifestyle.outdoor_levels_id
    fill_in "Profiles", with: @lifestyle.profiles_id
    fill_in "Social activities", with: @lifestyle.social_activities_id
    check "Studies" if @lifestyle.studies
    fill_in "Study hours", with: @lifestyle.study_hours
    fill_in "Work hours", with: @lifestyle.work_hours
    check "Works" if @lifestyle.works
    click_on "Update Lifestyle"

    assert_text "Lifestyle was successfully updated"
    click_on "Back"
  end

  test "destroying a Lifestyle" do
    visit lifestyles_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Lifestyle was successfully destroyed"
  end
end
