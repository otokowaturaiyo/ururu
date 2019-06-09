require 'test_helper'

class AdProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get ad_products_new_url
    assert_response :success
  end

  test "should get create" do
    get ad_products_create_url
    assert_response :success
  end

  test "should get edit" do
    get ad_products_edit_url
    assert_response :success
  end

  test "should get update" do
    get ad_products_update_url
    assert_response :success
  end

  test "should get show" do
    get ad_products_show_url
    assert_response :success
  end

end
