class ApplicationController < ActionController::Base
  protect_from_forgery

  respond_to :html

  before_filter :authenticate_user!
  before_filter :set_user_for_authorization
  
  rescue_from Authorization::NotAuthorized do |exception|
    respond_to do |wants|
      wants.html { flash[:alert] = exception.message; redirect_to root_url }
      wants.any(:xml, :json) { render :status => :forbidden, :text => exception.message, :layout => false}
    end
  end
  
  def permission_denied
    respond_to do |wants|
      wants.html { 
        flash[:error] = 'Sorry, you are not allowed to the requested page.'
        redirect_to(:back) rescue redirect_to('/') 
      }
      wants.any(:xml, :json) { render :status => :forbidden, :text => 'forbidden', :layout => false}
    end
  end
  
  protected
  def set_user_for_authorization
    Authorization.current_user = current_user
  end
end
