require 'test_helper'

class MeasuresControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get measure" do
    get :measure
    assert_response :success
  end

end
