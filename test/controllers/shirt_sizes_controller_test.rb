require 'test_helper'

class ShirtSizesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @shirt_size = shirt_sizes(:one)
  end

  test "should get index" do
    get shirt_sizes_url
    assert_response :success
  end

  test "should get new" do
    get new_shirt_size_url
    assert_response :success
  end

  test "should create shirt_size" do
    assert_difference('ShirtSize.count') do
      post shirt_sizes_url, params: { shirt_size: { size: @shirt_size.size } }
    end

    assert_redirected_to shirt_size_url(ShirtSize.last)
  end

  test "should show shirt_size" do
    get shirt_size_url(@shirt_size)
    assert_response :success
  end

  test "should get edit" do
    get edit_shirt_size_url(@shirt_size)
    assert_response :success
  end

  test "should update shirt_size" do
    patch shirt_size_url(@shirt_size), params: { shirt_size: { size: @shirt_size.size } }
    assert_redirected_to shirt_size_url(@shirt_size)
  end

  test "should destroy shirt_size" do
    assert_difference('ShirtSize.count', -1) do
      delete shirt_size_url(@shirt_size)
    end

    assert_redirected_to shirt_sizes_url
  end
end
