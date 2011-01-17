require 'test_helper'

class UserApiAuthTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = Factory(:api_user, :password => "monkey", :password_confirmation => 'monkey')
    @user.ensure_authentication_token!
  end
   
  def test_http_auth_with_user_name_password_fails
    args = prq('/users', {}, database_basic_auth_header(@user, 'monkey'))
    get *args
    assert_response 401
  end
  
  def test_token_auth_succeeds
    args = prq('/users')
    get *args
    assert_response :success
  end
  
  def test_token_auth_with_any_password_succeeds
    args = prq('/users', {}, token_basic_auth_header(@user, 'dannyzuko'))
    get *args
    assert_response :success
  end
  
  def prq(path, parameters={}, headers={})
    headers = default_headers.merge headers
    [path, parameters, headers]
  end

  def default_headers
    all = [ content_type_header("appliction/json"),
            accept_header("application/json"),
            token_basic_auth_header
          ]
    all.inject({}) { |headers, header| headers.merge header }
  end

  def content_type_header(type)
    {"HTTP_CONTENT_TYPE" => type.to_s}
  end

  def accept_header(*accepted)
    {"HTTP_ACCEPT" => accepted.collect {|a| a.to_s}}
  end

  def database_basic_auth_header(user=@user, password=nil)
    basic_auth_header user.login, password
  end

  def token_basic_auth_header(user=@user, password=nil)
    assert user.authentication_token
    basic_auth_header user.authentication_token
  end

  def basic_auth_header(username, password='')
    {"HTTP_AUTHORIZATION" => "Basic #{ActiveSupport::Base64.encode64("#{username}:#{password}")}"}
  end
    
end
