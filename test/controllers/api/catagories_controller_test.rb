require 'test_helper'

class Api::CatagoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_catagories_index_url
    assert_response :success
  end

end
