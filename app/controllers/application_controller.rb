class ApplicationController < ActionController::Base
  protect_from_forgery

  respond_to :html

  before_filter :authenticate_user!

  # Example of using the responders - this will render html, xml or json depending on the request
  # def show
  #   respond_with @user
  # end
end
