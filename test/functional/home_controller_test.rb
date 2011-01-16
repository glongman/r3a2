require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get redirected on index when not logged in  " do
    get :index
    assert_redirected_to new_user_session_url
  end

end
