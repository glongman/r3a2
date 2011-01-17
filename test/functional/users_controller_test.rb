require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  def setup
    @admin = Factory :admin_user
    @api = Factory :api_user
    @normal = Factory :normal_user
    5.times {Factory :normal_user}
  end
  
  def teardown
    User.delete_all
  end
  
  def test_index_not_logged_in
    get :index
    assert_response 401
  end
  
  def test_index_as_admin
    sign_in @admin
    get :index
    assert_response :success
    assert_equal User.count, assigns(:users).size
  end
  
  def test_index_as_api
    sign_in @api
    get :index
    assert_response :success
    assert_equal 6, assigns(:users).size
    assert_equal 0, assigns(:users).to_a.count(&:admin?)
    assert_equal 0, assigns(:users).to_a.count(&:api?)
  end
  
  def test_index_as_normal
    sign_in @normal
    get :index
    assert_response :forbidden
  end
  
end
