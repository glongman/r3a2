class UsersController < ApiBase
  filter_resource_access
  def index
    respond_with(@users = User.with_permissions_to(:update))
  end

  def show
    respond_with(@user)
  end

  def new
    respond_with(@user)
  end

  def create
    @user.update_attributes(params[:user])
    respond_with(@user)
  end

  def update
  end

  def delete
  end

end
