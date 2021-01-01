require 'test_helper'

class OutdoorLevelsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @outdoor_level = outdoor_levels(:one)
  end

  test "should get index" do
    get outdoor_levels_url
    assert_response :success
  end

  test "should get new" do
    get new_outdoor_level_url
    assert_response :success
  end

  test "should create outdoor_level" do
    assert_difference('OutdoorLevel.count') do
      post outdoor_levels_url, params: { outdoor_level: { level: @outdoor_level.level } }
    end

    assert_redirected_to outdoor_level_url(OutdoorLevel.last)
  end

  test "should show outdoor_level" do
    get outdoor_level_url(@outdoor_level)
    assert_response :success
  end

  test "should get edit" do
    get edit_outdoor_level_url(@outdoor_level)
    assert_response :success
  end

  test "should update outdoor_level" do
    patch outdoor_level_url(@outdoor_level), params: { outdoor_level: { level: @outdoor_level.level } }
    assert_redirected_to outdoor_level_url(@outdoor_level)
  end

  test "should destroy outdoor_level" do
    assert_difference('OutdoorLevel.count', -1) do
      delete outdoor_level_url(@outdoor_level)
    end

    assert_redirected_to outdoor_levels_url
  end
end
