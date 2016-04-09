require 'test_helper'

class ProductsLoadControllerTest < ActionController::TestCase
  test "should get status" do
    get :status
    assert_response :success
  end

end
