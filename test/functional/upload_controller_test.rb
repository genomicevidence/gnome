require 'test_helper'

class UploadControllerTest < ActionController::TestCase
  test "should get case_control" do
    get :case_control
    assert_response :success
  end

  test "should get case_only" do
    get :case_only
    assert_response :success
  end

  test "should get family" do
    get :family
    assert_response :success
  end

  test "should get healthy" do
    get :healthy
    assert_response :success
  end

end
