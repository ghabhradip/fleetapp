require 'test_helper'

class ValetControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get valet_index_url
    assert_response :success
  end

  test "should get new" do
    get valet_new_url
    assert_response :success
  end

  test "should get create" do
    get valet_create_url
    assert_response :success
  end

  test "should get edit" do
    get valet_edit_url
    assert_response :success
  end

  test "should get update" do
    get valet_update_url
    assert_response :success
  end

  test "should get show" do
    get valet_show_url
    assert_response :success
  end

  test "should get destroy" do
    get valet_destroy_url
    assert_response :success
  end

end
