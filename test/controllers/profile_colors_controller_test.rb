require "test_helper"

class ProfileColorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @profile_color = profile_colors(:one)
  end

  test "should get index" do
    get profile_colors_url
    assert_response :success
  end

  test "should get new" do
    get new_profile_color_url
    assert_response :success
  end

  test "should create profile_color" do
    assert_difference('ProfileColor.count') do
      post profile_colors_url, params: { profile_color: { color: @profile_color.color, profile_id: @profile_color.profile_id } }
    end

    assert_redirected_to profile_color_url(ProfileColor.last)
  end

  test "should show profile_color" do
    get profile_color_url(@profile_color)
    assert_response :success
  end

  test "should get edit" do
    get edit_profile_color_url(@profile_color)
    assert_response :success
  end

  test "should update profile_color" do
    patch profile_color_url(@profile_color), params: { profile_color: { color: @profile_color.color, profile_id: @profile_color.profile_id } }
    assert_redirected_to profile_color_url(@profile_color)
  end

  test "should destroy profile_color" do
    assert_difference('ProfileColor.count', -1) do
      delete profile_color_url(@profile_color)
    end

    assert_redirected_to profile_colors_url
  end
end
