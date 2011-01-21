class UsersController < ApiBase
  filter_resource_access
  def index
    respond_with(@users = User.with_permissions_to(:show))
  end
  
  def show
    respond_with @user
  end

  def new
    respond_with( @user = User.new, :template => 'edit')
  end
  
  def edit
    respond_with @user
  end

  def create
    @user.update_attributes params[:user]
    respond_with @user
  end

  def update
    @user.update_attributes params[:user]
    respond_with @user
  end

  def delete
    respond_with @user.destroy
  end

end
