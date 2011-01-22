class Player < ActiveRecord::Base
  belongs_to :user
  has_many :scores
  
  devise :lockable
  
  validates_presence_of   :name
  validates_uniqueness_of :name
  validates_presence_of   :email
  validates_format_of     :email, :with  => /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i, :allow_blank => true
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :name
end
