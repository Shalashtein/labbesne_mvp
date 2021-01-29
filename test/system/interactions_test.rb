require "application_system_test_case"

class InteractionsTest < ApplicationSystemTestCase
  setup do
    @interaction = interactions(:one)
  end

  test "visiting the index" do
    visit interactions_url
    assert_selector "h1", text: "Interactions"
  end

  test "creating a Interaction" do
    visit interactions_url
    click_on "New Interaction"

    check "Bought" if @interaction.bought
    fill_in "Dislike count", with: @interaction.dislike_count
    check "Expanded" if @interaction.expanded
    fill_in "Like count", with: @interaction.like_count
    fill_in "Spree product", with: @interaction.spree_product_id
    fill_in "Spree user", with: @interaction.spree_user_id
    check "Swiped" if @interaction.swiped
    click_on "Create Interaction"

    assert_text "Interaction was successfully created"
    click_on "Back"
  end

  test "updating a Interaction" do
    visit interactions_url
    click_on "Edit", match: :first

    check "Bought" if @interaction.bought
    fill_in "Dislike count", with: @interaction.dislike_count
    check "Expanded" if @interaction.expanded
    fill_in "Like count", with: @interaction.like_count
    fill_in "Spree product", with: @interaction.spree_product_id
    fill_in "Spree user", with: @interaction.spree_user_id
    check "Swiped" if @interaction.swiped
    click_on "Update Interaction"

    assert_text "Interaction was successfully updated"
    click_on "Back"
  end

  test "destroying a Interaction" do
    visit interactions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Interaction was successfully destroyed"
  end
end
