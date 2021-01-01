require "application_system_test_case"

class BodyMeasurementsTest < ApplicationSystemTestCase
  setup do
    @body_measurement = body_measurements(:one)
  end

  test "visiting the index" do
    visit body_measurements_url
    assert_selector "h1", text: "Body Measurements"
  end

  test "creating a Body measurement" do
    visit body_measurements_url
    click_on "New Body Measurement"

    fill_in "Body types", with: @body_measurement.body_types_id
    fill_in "Height", with: @body_measurement.height
    fill_in "Pants size", with: @body_measurement.pants_size
    fill_in "Profiles", with: @body_measurement.profiles_id
    fill_in "Shirt size", with: @body_measurement.shirt_size
    fill_in "Shoe size", with: @body_measurement.shoe_size
    fill_in "Weight", with: @body_measurement.weight
    click_on "Create Body measurement"

    assert_text "Body measurement was successfully created"
    click_on "Back"
  end

  test "updating a Body measurement" do
    visit body_measurements_url
    click_on "Edit", match: :first

    fill_in "Body types", with: @body_measurement.body_types_id
    fill_in "Height", with: @body_measurement.height
    fill_in "Pants size", with: @body_measurement.pants_size
    fill_in "Profiles", with: @body_measurement.profiles_id
    fill_in "Shirt size", with: @body_measurement.shirt_size
    fill_in "Shoe size", with: @body_measurement.shoe_size
    fill_in "Weight", with: @body_measurement.weight
    click_on "Update Body measurement"

    assert_text "Body measurement was successfully updated"
    click_on "Back"
  end

  test "destroying a Body measurement" do
    visit body_measurements_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Body measurement was successfully destroyed"
  end
end
