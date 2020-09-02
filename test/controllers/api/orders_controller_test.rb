require 'test_helper'

class Api::OrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get create_intent" do
    get api_orders_create_intent_url
    assert_response :success
  end

end
