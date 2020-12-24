require "application_system_test_case"

class TracksTest < ApplicationSystemTestCase
  setup do
    @track = tracks(:one)
  end

  test "visiting the index" do
    visit tracks_url
    assert_selector "h1", text: "Tracks"
  end

  test "creating a Track" do
    visit tracks_url
    click_on "New Track"

    check "Recieved" if @track.recieved
    fill_in "Spree line item", with: @track.spree_line_item_id
    check "Vendor recieved" if @track.vendor_recieved
    check "Vendor sent" if @track.vendor_sent
    click_on "Create Track"

    assert_text "Track was successfully created"
    click_on "Back"
  end

  test "updating a Track" do
    visit tracks_url
    click_on "Edit", match: :first

    check "Recieved" if @track.recieved
    fill_in "Spree line item", with: @track.spree_line_item_id
    check "Vendor recieved" if @track.vendor_recieved
    check "Vendor sent" if @track.vendor_sent
    click_on "Update Track"

    assert_text "Track was successfully updated"
    click_on "Back"
  end

  test "destroying a Track" do
    visit tracks_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Track was successfully destroyed"
  end
end
