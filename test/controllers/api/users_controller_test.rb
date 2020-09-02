require 'test_helper'

class Api::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get api_users_login_url
    assert_response :success
  end

  test "should get signup" do
    get api_users_signup_url
    assert_response :success
  end

  test "should get update" do
    get api_users_update_url
    assert_response :success
  end

  test "should get update_password" do
    get api_users_update_password_url
    assert_response :success
  end

end
