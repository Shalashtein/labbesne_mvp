require "application_system_test_case"

class ShoeSizesTest < ApplicationSystemTestCase
  setup do
    @shoe_size = shoe_sizes(:one)
  end

  test "visiting the index" do
    visit shoe_sizes_url
    assert_selector "h1", text: "Shoe Sizes"
  end

  test "creating a Shoe size" do
    visit shoe_sizes_url
    click_on "New Shoe Size"

    fill_in "Eur", with: @shoe_size.EUR
    fill_in "Us", with: @shoe_size.US
    click_on "Create Shoe size"

    assert_text "Shoe size was successfully created"
    click_on "Back"
  end

  test "updating a Shoe size" do
    visit shoe_sizes_url
    click_on "Edit", match: :first

    fill_in "Eur", with: @shoe_size.EUR
    fill_in "Us", with: @shoe_size.US
    click_on "Update Shoe size"

    assert_text "Shoe size was successfully updated"
    click_on "Back"
  end

  test "destroying a Shoe size" do
    visit shoe_sizes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Shoe size was successfully destroyed"
  end
end
