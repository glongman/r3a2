class ApiBase < ApplicationController
  responders :http_cache
  respond_to :xml, :json
  prepend_before_filter :check_format
  skip_before_filter :verify_authenticity_token
  after_filter :clear_session_if_by_token
  
  rescue_from ActiveRecord::RecordNotFound do |why|
    response.headers["Content-Type"] = "text/plain"
    render :text => why.message, :status => 404
  end
  
  # XXXX the invalid json error occurs too early for this to work
  # Look at the params_parser middleware
  # rescue_from StandardError do |why|
  #   debugger
  #   raise unless why.message =~ /Invalid JSON string/
  #   render :text => why.message, :status => 400
  # end
  
  private
  def check_format
    if ![Mime::XML, Mime::JSON].include?(request.format)
      request.format = :json
    end
  end
  
  def clear_session_if_by_token
    reset_session if current_user && current_user.was_authenticated_by_token
  end
end