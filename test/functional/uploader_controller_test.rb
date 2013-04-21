require 'test_helper'

class UploaderControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get loading" do
    get :loading
    assert_response :success
  end

  test "should get finished" do
    get :finished
    assert_response :success
  end

end
