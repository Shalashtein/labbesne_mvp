require "test_helper"

class ProductOutfitsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product_outfit = product_outfits(:one)
  end

  test "should get index" do
    get product_outfits_url
    assert_response :success
  end

  test "should get new" do
    get new_product_outfit_url
    assert_response :success
  end

  test "should create product_outfit" do
    assert_difference('ProductOutfit.count') do
      post product_outfits_url, params: { product_outfit: { outfit_id: @product_outfit.outfit_id, spree_product_id: @product_outfit.spree_product_id } }
    end

    assert_redirected_to product_outfit_url(ProductOutfit.last)
  end

  test "should show product_outfit" do
    get product_outfit_url(@product_outfit)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_outfit_url(@product_outfit)
    assert_response :success
  end

  test "should update product_outfit" do
    patch product_outfit_url(@product_outfit), params: { product_outfit: { outfit_id: @product_outfit.outfit_id, spree_product_id: @product_outfit.spree_product_id } }
    assert_redirected_to product_outfit_url(@product_outfit)
  end

  test "should destroy product_outfit" do
    assert_difference('ProductOutfit.count', -1) do
      delete product_outfit_url(@product_outfit)
    end

    assert_redirected_to product_outfits_url
  end
end
