class User < ActiveRecord::Base
  ALLOWED_ROLES = %(admin api normal).freeze
  
  devise :token_authenticatable, :database_authenticatable, :validatable, :recoverable, :trackable, :lockable
           
  has_many :players
  
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
    
  # role?
  def api?; self.role == "api"  end
  
  def admin?; self.role == "admin" end
end
