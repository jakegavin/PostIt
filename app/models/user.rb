class User < ActiveRecord::Base
  include SluggableJake

  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false
  
  validates :username, presence: true, uniqueness: true, format: {:with => /\A[\w\-]*\Z/}
  validates :password, length: { minimum: 5}, on: :create 
  
  sluggable_column :username

  def admin?
    self.role == 'admin'
  end

  def to_json(options)
    super(:except => [:id, :role, :password_digest, :slug])
  end

  def to_xml(options)
    super(:except => [:id, :role, :password_digest, :slug])
  end
end