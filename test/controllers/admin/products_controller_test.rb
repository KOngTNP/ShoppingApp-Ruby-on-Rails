require "test_helper"

class Admin::ProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get _admin_product" do
    get admin_products__admin_product_url
    assert_response :success
  end

  test "should get edit" do
    get admin_products_edit_url
    assert_response :success
  end

  test "should get index" do
    get admin_products_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_products_new_url
    assert_response :success
  end
end
