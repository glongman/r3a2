class UsersController < ApiBase
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
    respond_with User.create(params[:user])
  end

  def update
    @user.update_attributes params[:user]
    respond_with @user
  end

  def delete
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
