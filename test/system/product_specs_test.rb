require "application_system_test_case"

class ProductSpecsTest < ApplicationSystemTestCase
  setup do
    @product_spec = product_specs(:one)
  end

  test "visiting the index" do
    visit product_specs_url
    assert_selector "h1", text: "Product Specs"
  end

  test "creating a Product spec" do
    visit product_specs_url
    click_on "New Product Spec"

    fill_in "Specs", with: @product_spec.specs_id
    fill_in "Spree product", with: @product_spec.spree_product_id
    click_on "Create Product spec"

    assert_text "Product spec was successfully created"
    click_on "Back"
  end

  test "updating a Product spec" do
    visit product_specs_url
    click_on "Edit", match: :first

    fill_in "Specs", with: @product_spec.specs_id
    fill_in "Spree product", with: @product_spec.spree_product_id
    click_on "Update Product spec"

    assert_text "Product spec was successfully updated"
    click_on "Back"
  end

  test "destroying a Product spec" do
    visit product_specs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Product spec was successfully destroyed"
  end
end
