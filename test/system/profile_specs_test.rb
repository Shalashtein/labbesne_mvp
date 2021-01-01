require "application_system_test_case"

class ProfileSpecsTest < ApplicationSystemTestCase
  setup do
    @profile_spec = profile_specs(:one)
  end

  test "visiting the index" do
    visit profile_specs_url
    assert_selector "h1", text: "Profile Specs"
  end

  test "creating a Profile spec" do
    visit profile_specs_url
    click_on "New Profile Spec"

    fill_in "Profiles", with: @profile_spec.profiles_id
    fill_in "Specs", with: @profile_spec.specs_id
    fill_in "Value", with: @profile_spec.value
    click_on "Create Profile spec"

    assert_text "Profile spec was successfully created"
    click_on "Back"
  end

  test "updating a Profile spec" do
    visit profile_specs_url
    click_on "Edit", match: :first

    fill_in "Profiles", with: @profile_spec.profiles_id
    fill_in "Specs", with: @profile_spec.specs_id
    fill_in "Value", with: @profile_spec.value
    click_on "Update Profile spec"

    assert_text "Profile spec was successfully updated"
    click_on "Back"
  end

  test "destroying a Profile spec" do
    visit profile_specs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Profile spec was successfully destroyed"
  end
end
