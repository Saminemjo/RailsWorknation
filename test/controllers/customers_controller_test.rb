require 'test_helper'

class RequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get Requests_index_url
    assert_response :success
  end

end
