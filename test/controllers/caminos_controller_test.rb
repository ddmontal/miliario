require 'test_helper'

class CaminosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
