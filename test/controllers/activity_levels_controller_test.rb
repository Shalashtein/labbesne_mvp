require 'test_helper'

class ActivityLevelsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @activity_level = activity_levels(:one)
  end

  test "should get index" do
    get activity_levels_url
    assert_response :success
  end

  test "should get new" do
    get new_activity_level_url
    assert_response :success
  end

  test "should create activity_level" do
    assert_difference('ActivityLevel.count') do
      post activity_levels_url, params: { activity_level: { name: @activity_level.name } }
    end

    assert_redirected_to activity_level_url(ActivityLevel.last)
  end

  test "should show activity_level" do
    get activity_level_url(@activity_level)
    assert_response :success
  end

  test "should get edit" do
    get edit_activity_level_url(@activity_level)
    assert_response :success
  end

  test "should update activity_level" do
    patch activity_level_url(@activity_level), params: { activity_level: { name: @activity_level.name } }
    assert_redirected_to activity_level_url(@activity_level)
  end

  test "should destroy activity_level" do
    assert_difference('ActivityLevel.count', -1) do
      delete activity_level_url(@activity_level)
    end

    assert_redirected_to activity_levels_url
  end
end
