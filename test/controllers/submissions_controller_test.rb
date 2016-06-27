require 'test_helper'

class SubmissionsControllerTest < ActionController::TestCase

  test "show a submission" do
  	sign_in User.find(21)
    get :show, :id => 18, :matrix_id => 1
    assert_response :success
  end

   test "Generate required variables to generate" do
  	sign_in User.find(21)
    get :show, :id => 18, :matrix_id => 1
    assert_response :success
  end

end
