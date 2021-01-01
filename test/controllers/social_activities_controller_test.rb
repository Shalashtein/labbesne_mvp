require 'test_helper'

class SocialActivitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @social_activity = social_activities(:one)
  end

  test "should get index" do
    get social_activities_url
    assert_response :success
  end

  test "should get new" do
    get new_social_activity_url
    assert_response :success
  end

  test "should create social_activity" do
    assert_difference('SocialActivity.count') do
      post social_activities_url, params: { social_activity: { name: @social_activity.name } }
    end

    assert_redirected_to social_activity_url(SocialActivity.last)
  end

  test "should show social_activity" do
    get social_activity_url(@social_activity)
    assert_response :success
  end

  test "should get edit" do
    get edit_social_activity_url(@social_activity)
    assert_response :success
  end

  test "should update social_activity" do
    patch social_activity_url(@social_activity), params: { social_activity: { name: @social_activity.name } }
    assert_redirected_to social_activity_url(@social_activity)
  end

  test "should destroy social_activity" do
    assert_difference('SocialActivity.count', -1) do
      delete social_activity_url(@social_activity)
    end

    assert_redirected_to social_activities_url
  end
end
