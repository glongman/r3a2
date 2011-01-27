require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  def setup
    @admin = Factory :admin_user
    @api = Factory :api_user
    @normal = Factory :normal_user
    5.times {Factory :normal_user}
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

  def test_new_as_admin
    sign_in @admin
    get :new
    assert_response :success
   end
  
  def test_new_as_api
    sign_in @api
    get :new
    assert_response :success
  end
  
  def test_index_as_normal
    sign_in @normal
    get :index
    assert_response :forbidden
  end
  
  def test_new_as_normal
    sign_in @normal
    get :new
    assert_response :forbidden
  end
  
  def test_edit_admin_as_admin
    sign_in @admin
    get :edit, :id => @admin.id
    assert_response :success
  end
  
  def test_edit_api_as_admin
    sign_in @admin
    get :edit, :id => @api.id
    assert_response :success
  end
  
  def test_edit_normal_as_admin
    sign_in @admin
    get :edit, :id => @normal.id
    assert_response :success
  end
  
  def test_create_admin_as_admin
    sign_in @admin
    create_user :role => 'admin'
    assert_response :forbidden
  end
  
  def test_create_api_as_admin
    sign_in @admin
    create_user :role => 'api'
    assert_response :success
  end
  
  def test_create_admin_as_api
    sign_in @api
    create_user :role => 'admin'
    assert_response :forbidden
  end
  
  def test_create_api_as_api
    sign_in @api
    create_user :role => 'api'
    assert_response :forbidden
  end
  
  def test_create_normal_as_api
    sign_in @api
    create_user :role => 'normal'
    assert_response :success
  end
  
  def test_update_any_as_admin_not_role
    sign_in @admin
    update_user @admin, {:name => 'foo'}
    assert_response :success
    update_user @api, {:name => 'foo'}
    assert_response :success
    update_user @normal, {:name => 'foo'}
    assert_response :success
  end
  
  def test_cant_admin_cant_change_own_role
    sign_in @admin
    update_user @admin, {:role => 'api'}
    assert_response :forbidden
  end
  
  def test_api_cant_update_admin
    sign_in @api
    update_user @admin, :role => 'normal'
    assert_response :forbidden
  end
  
  def test_api_can_update_self
    sign_in @api
    update_user @api, :name => 'foo'
    assert_response :success
  end
  
  def test_api_cant_update_another_api
    other = Factory :api_user
    sign_in @api
    update_user other, :name => 'foo'
    assert_response :forbidden
  end
  
  def test_api_can_update_normal
    sign_in @api
    update_user @normal, :name => 'foo'
    assert_response :success
  end
  
  def test_api_cant_turn_normal_into_api
    sign_in @api
    update_user @normal, :role => 'api'
    assert_response :forbidden
  end
  
  def test_api_cant_turn_self_into_admin
    sign_in @api
    update_user  @api, :role => 'admin'
    assert_response :forbidden
  end
  
  def test_normal_can_update_self
    sign_in @normal
    update_user @normal, :name => 'foo'
    assert_response :success
  end
  
  def test_normal_cant_update_others
    sign_in @normal
    update_user @admin, :name => 'foo'
    assert_response :forbidden
    
    update_user @api, :name => 'foo'
    assert_response :forbidden
    
    other_normal = Factory :normal_user
    update_user other_normal, :name => 'foo'
    
    assert_response :forbidden
  end
  
  def test_admin_cant_destroy_self
    sign_in @admin
    destroy_user @admin
    assert_response :forbidden
  end
  
  def test_admin_can_destroy_others
    sign_in @admin
    destroy_user @api
    assert_response :success
    
    destroy_user @normal
    assert_response :success
  end
  
  def test_api_can_destroy_normal
    sign_in @api
    destroy_user @normal
    assert_response :success
  end
  
  def test_api_cant_destroy_admin_or_api
    sign_in @api
    destroy_user @api
    assert_response :forbidden
    
    destroy_user @admin
    assert_response :forbidden
    
    other_api = Factory :api_user
    destroy_user other_api
    assert_response :forbidden
  end
  
  def test_normal_cant_destroy_anyone
    sign_in @normal
    destroy_user @normal
    assert_response :forbidden
    
    destroy_user @admin
    assert_response :forbidden
    
    destroy_user @api
    assert_response :forbidden
    
    other_normal = Factory :normal_user
    destroy_user other_normal
    assert_response :forbidden
  end
  
  def test_admin_can_read_locks
    sign_in @admin
    read_lock @admin
    assert_response :success
    
    read_lock @api
    assert_response :success
    
    read_lock @normal
    assert_response :success
  end
  
  def test_admin_cant_lock_self
    sign_in @admin
    lock @admin
    assert_response :forbidden
  end
  
  def test_admin_can_lock_others
    sign_in @admin
    lock @api
    assert_response :success
    
    lock @normal
    assert_response :success
  end
  
  def test_admin_can_unlock_api
    sign_in @admin
    unlock @api
    assert_response :success
  end
  
  def test_admin_can_unlock_normal
    sign_in @admin
    unlock @normal
    assert_response :success
  end
  
  def test_api_can_read_locks
    sign_in @api
    read_lock @admin
    assert_response :success
    
    read_lock @api
    assert_response :success
    
    read_lock @normal
    assert_response :success
  end
  
  def test_api_cant_lock_admin
    sign_in @api
    lock @admin
    assert_response :forbidden
  end
  
  def test_api_cant_lock_api
    sign_in @api
    lock @api
    assert_response :forbidden
  end
  
  def test_api_cant_lock_normal
    sign_in @api
    lock @normal
    assert_response :forbidden
  end
  
  def test_api_cant_unlock_admin
    sign_in @api
    unlock @admin
    assert_response :forbidden
  end
    
  def test_api_cant_unlock_api
    sign_in @api
    unlock Factory :api_user
    assert_response :forbidden
  end
  
  def test_api_cant_unlock_normal
    sign_in @api
    unlock @normal
    assert_response :forbidden
  end
  
  protected
  
  def read_lock(user)
    get :show_lock, :id => user.id
  end
  
  def lock(user)
    post :lock, :id => user.id
  end
  
  def unlock(user)
    # ensure the lock is set
    user.lock_access!
    user.reload
    delete :unlock, :id => user.id
  end
  
  
  def destroy_user(user)
    post :destroy, :id => user.id
  end
  
  def update_user(user, attrs)
    put :update, :id => user.id, :user => attrs
  end
  
  def create_user(options={})
    post :create, :user => {
      :name => "fooboy",
      :email => 'myemail@example.com',
      :login => "fooboy",
      :password => 'fooboy94',
      :role => 'normal'
    }.merge(options)
  end
  
end
