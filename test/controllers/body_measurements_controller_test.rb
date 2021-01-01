require 'test_helper'

class BodyMeasurementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @body_measurement = body_measurements(:one)
  end

  test "should get index" do
    get body_measurements_url
    assert_response :success
  end

  test "should get new" do
    get new_body_measurement_url
    assert_response :success
  end

  test "should create body_measurement" do
    assert_difference('BodyMeasurement.count') do
      post body_measurements_url, params: { body_measurement: { body_types_id: @body_measurement.body_types_id, height: @body_measurement.height, pants_size: @body_measurement.pants_size, profiles_id: @body_measurement.profiles_id, shirt_size: @body_measurement.shirt_size, shoe_size: @body_measurement.shoe_size, weight: @body_measurement.weight } }
    end

    assert_redirected_to body_measurement_url(BodyMeasurement.last)
  end

  test "should show body_measurement" do
    get body_measurement_url(@body_measurement)
    assert_response :success
  end

  test "should get edit" do
    get edit_body_measurement_url(@body_measurement)
    assert_response :success
  end

  test "should update body_measurement" do
    patch body_measurement_url(@body_measurement), params: { body_measurement: { body_types_id: @body_measurement.body_types_id, height: @body_measurement.height, pants_size: @body_measurement.pants_size, profiles_id: @body_measurement.profiles_id, shirt_size: @body_measurement.shirt_size, shoe_size: @body_measurement.shoe_size, weight: @body_measurement.weight } }
    assert_redirected_to body_measurement_url(@body_measurement)
  end

  test "should destroy body_measurement" do
    assert_difference('BodyMeasurement.count', -1) do
      delete body_measurement_url(@body_measurement)
    end

    assert_redirected_to body_measurements_url
  end
end
