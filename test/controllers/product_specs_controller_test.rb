require 'test_helper'

class ProductSpecsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product_spec = product_specs(:one)
  end

  test "should get index" do
    get product_specs_url
    assert_response :success
  end

  test "should get new" do
    get new_product_spec_url
    assert_response :success
  end

  test "should create product_spec" do
    assert_difference('ProductSpec.count') do
      post product_specs_url, params: { product_spec: { specs_id: @product_spec.specs_id, spree_product_id: @product_spec.spree_product_id } }
    end

    assert_redirected_to product_spec_url(ProductSpec.last)
  end

  test "should show product_spec" do
    get product_spec_url(@product_spec)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_spec_url(@product_spec)
    assert_response :success
  end

  test "should update product_spec" do
    patch product_spec_url(@product_spec), params: { product_spec: { specs_id: @product_spec.specs_id, spree_product_id: @product_spec.spree_product_id } }
    assert_redirected_to product_spec_url(@product_spec)
  end

  test "should destroy product_spec" do
    assert_difference('ProductSpec.count', -1) do
      delete product_spec_url(@product_spec)
    end

    assert_redirected_to product_specs_url
  end
end
