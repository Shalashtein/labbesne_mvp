require "application_system_test_case"

class BodyTypesTest < ApplicationSystemTestCase
  setup do
    @body_type = body_types(:one)
  end

  test "visiting the index" do
    visit body_types_url
    assert_selector "h1", text: "Body Types"
  end

  test "creating a Body type" do
    visit body_types_url
    click_on "New Body Type"

    fill_in "Name", with: @body_type.name
    click_on "Create Body type"

    assert_text "Body type was successfully created"
    click_on "Back"
  end

  test "updating a Body type" do
    visit body_types_url
    click_on "Edit", match: :first

    fill_in "Name", with: @body_type.name
    click_on "Update Body type"

    assert_text "Body type was successfully updated"
    click_on "Back"
  end

  test "destroying a Body type" do
    visit body_types_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Body type was successfully destroyed"
  end
end
