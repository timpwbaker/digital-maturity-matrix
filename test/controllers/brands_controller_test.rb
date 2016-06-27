require 'test_helper'

class BrandsControllerTest < ActionController::TestCase
  test 'show new brand page' do
    sign_in User.find(22)
    get :new, submission_id: 18, matrix_id: 1
    assert_response :success
  end

  test 'should update brand' do
    sign_in User.find(21)
    put :update, id: 2, brand: { submission_id: 18, matrix_id: 1, color_a: '#381634' }
    assert_equal '#381634', assigns(:brand).color_a
  end
end
