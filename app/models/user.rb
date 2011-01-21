class User < ActiveRecord::Base
  API_DEFAULT_ATTRIBUTES = %w(id login role email name locked_at).map(&:to_sym).freeze
  ALLOWED_ROLES = %(admin api normal).freeze
  
  devise :token_authenticatable, :database_authenticatable, :validatable, :recoverable, :trackable, :lockable
           
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :login, :role, :name

  validates_uniqueness_of :login, :allow_nil=>true
  validates_format_of :login, :with => /^[^@\s]*$/i, :message => "You can't have @ or spaces in your login" # Logins cannot have @ symbols or spaces
  validates_inclusion_of :role, :in => ALLOWED_ROLES
  
  attr_reader :was_authenticated_by_token
  
  # Case insensitive login/email
  # never lock out admin users
  before_validation do
    self.email = self.email.downcase if self.email
    self.login = self.login.downcase if self.login
    self.locked_at = nil if self.role == 'admin'
  end

  def self.find_for_database_authentication(conditions)
    value = conditions[authentication_keys.first]
    where(["login = :value OR email = :value", { :value => value.downcase }]).first
  end
  
  def role_symbols
    [role.to_sym] rescue []
  end
  
  # set a flag
  def after_authentication_by_token
    @was_authenticated_by_token
  end
  
  def as_json_with_filter(options = nil, &block)
    options = {:only => API_DEFAULT_ATTRIBUTES} if options.blank? || options.keys.select {|i| [:only,:except, :methods, :include].include?(i)}.empty?
    json = as_json_without_filter(options)
    yield json if block_given?
    json
  end
  alias_method_chain :as_json, :filter
  
  def to_xml_with_filter(*args, &block)
    options = args.extract_options! # throw away any options
    options[:only] = API_DEFAULT_ATTRIBUTES unless options[:only] || options[:except]
    options[:skip_types] = true
    args << options
    to_xml_without_filter(*args, &block)
  end
  alias_method_chain :to_xml, :filter
  
  # role?
  def api?; self.role == "api"  end
  
  def admin?; self.role == "admin" end
end
