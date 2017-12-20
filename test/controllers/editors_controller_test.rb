require 'test_helper'

class EditorsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get editors_index_url
    assert_response :success
  end

end
