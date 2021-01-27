require "application_system_test_case"

class ProductOutfitsTest < ApplicationSystemTestCase
  setup do
    @product_outfit = product_outfits(:one)
  end

  test "visiting the index" do
    visit product_outfits_url
    assert_selector "h1", text: "Product Outfits"
  end

  test "creating a Product outfit" do
    visit product_outfits_url
    click_on "New Product Outfit"

    fill_in "Outfit", with: @product_outfit.outfit_id
    fill_in "Spree product", with: @product_outfit.spree_product_id
    click_on "Create Product outfit"

    assert_text "Product outfit was successfully created"
    click_on "Back"
  end

  test "updating a Product outfit" do
    visit product_outfits_url
    click_on "Edit", match: :first

    fill_in "Outfit", with: @product_outfit.outfit_id
    fill_in "Spree product", with: @product_outfit.spree_product_id
    click_on "Update Product outfit"

    assert_text "Product outfit was successfully updated"
    click_on "Back"
  end

  test "destroying a Product outfit" do
    visit product_outfits_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Product outfit was successfully destroyed"
  end
end
