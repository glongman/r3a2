class UsersController < ApiBase
  before_filter :role_update_auth, :only => :update
  filter_resource_access
  filter_access_to [:show_lock, :lock, :unlock], :attribute_check => true
  def index
    respond_with(@users = User.with_permissions_to(:show))
  end
  
  def show
    respond_with @user
  end

  def new
    respond_with(@user = User.new, :template => 'edit')
  end
  
  def edit
    respond_with @user
  end

  def create
    @user.save
    respond_with @user
  end

  def update
    params[:user].merge!(:password_confirmation => params[:user][:password]) if params[:user] && params[:user][:password]
    @user.update_attributes params[:user]
    respond_with @user
  end

  def destroy
    respond_with @user.destroy
  end
  
  def show_lock
    respond_with @user
  end
  
  def unlock
    @user.unlock_access!
    respond_with @user
  end
  
  def lock
    @user.lock_access!
    respond_with @user
  end
  
  protected
  
  def new_user_from_params
    params[:user].merge!(:password_confirmation => params[:user][:password]) if params[:user] && params[:user][:password]
    @user = User.new params[:user]
  end
  
  def role_update_auth
    # getting here means current_user can update
    # but, is the role value supplied, if any, allowed?
    requested_role = params[:user][:role] if params[:user]
    return unless requested_role
    allowed = true
    if has_role? :admin
      allowed = false unless requested_role == 'admin'
    else
      allowed = false
    end
    raise Authorization::NotAuthorized, "Authorized user can't update user role to #{requested_role.inspect}" unless allowed
  end

end

# lock_user GET    /users/:id/lock(.:format)                     {:controller=>"users", :action=>"show_lock"}
#           PUT    /users/:id/lock(.:format)                     {:controller=>"users", :action=>"lock"}
#           DELETE /users/:id/lock(.:format)                     {:controller=>"users", :action=>"unlock"}
#     users GET    /users(.:format)                              {:controller=>"users", :action=>"index"}
#           POST   /users(.:format)                              {:controller=>"users", :action=>"create"}
#  new_user GET    /users/new(.:format)                          {:controller=>"users", :action=>"new"}
# edit_user GET    /users/:id/edit(.:format)                     {:controller=>"users", :action=>"edit"}
#      user GET    /users/:id(.:format)                          {:controller=>"users", :action=>"show"}
#           PUT    /users/:id(.:format)                          {:controller=>"users", :action=>"update"}
#           DELETE /users/:id(.:format)                          {:controller=>"users", :action=>"destroy"}
