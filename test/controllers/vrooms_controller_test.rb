require 'test_helper'

class VroomsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get vrooms_index_url
    assert_response :success
  end

  test "should get create" do
    get vrooms_create_url
    assert_response :success
  end

  test "should get party" do
    get vrooms_party_url
    assert_response :success
  end

  test "should get config_opentok" do
    get vrooms_config_opentok_url
    assert_response :success
  end

end
