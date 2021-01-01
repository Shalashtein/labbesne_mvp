require 'test_helper'

class ProfileSpecsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @profile_spec = profile_specs(:one)
  end

  test "should get index" do
    get profile_specs_url
    assert_response :success
  end

  test "should get new" do
    get new_profile_spec_url
    assert_response :success
  end

  test "should create profile_spec" do
    assert_difference('ProfileSpec.count') do
      post profile_specs_url, params: { profile_spec: { profiles_id: @profile_spec.profiles_id, specs_id: @profile_spec.specs_id, value: @profile_spec.value } }
    end

    assert_redirected_to profile_spec_url(ProfileSpec.last)
  end

  test "should show profile_spec" do
    get profile_spec_url(@profile_spec)
    assert_response :success
  end

  test "should get edit" do
    get edit_profile_spec_url(@profile_spec)
    assert_response :success
  end

  test "should update profile_spec" do
    patch profile_spec_url(@profile_spec), params: { profile_spec: { profiles_id: @profile_spec.profiles_id, specs_id: @profile_spec.specs_id, value: @profile_spec.value } }
    assert_redirected_to profile_spec_url(@profile_spec)
  end

  test "should destroy profile_spec" do
    assert_difference('ProfileSpec.count', -1) do
      delete profile_spec_url(@profile_spec)
    end

    assert_redirected_to profile_specs_url
  end
end
