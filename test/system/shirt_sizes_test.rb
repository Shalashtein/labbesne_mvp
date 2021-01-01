require "application_system_test_case"

class ShirtSizesTest < ApplicationSystemTestCase
  setup do
    @shirt_size = shirt_sizes(:one)
  end

  test "visiting the index" do
    visit shirt_sizes_url
    assert_selector "h1", text: "Shirt Sizes"
  end

  test "creating a Shirt size" do
    visit shirt_sizes_url
    click_on "New Shirt Size"

    fill_in "Size", with: @shirt_size.size
    click_on "Create Shirt size"

    assert_text "Shirt size was successfully created"
    click_on "Back"
  end

  test "updating a Shirt size" do
    visit shirt_sizes_url
    click_on "Edit", match: :first

    fill_in "Size", with: @shirt_size.size
    click_on "Update Shirt size"

    assert_text "Shirt size was successfully updated"
    click_on "Back"
  end

  test "destroying a Shirt size" do
    visit shirt_sizes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Shirt size was successfully destroyed"
  end
end
