class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false
  
  validates :username, presence: true, uniqueness: true, format: {:with => /\A[\w\-]*\Z/}
  validates :password, length: { minimum: 5}, on: :create 
  
  after_validation :generate_slug!

  def to_param
    self.slug
  end

  def generate_slug!
    self.slug = self.username.gsub(/\W/, '-').downcase
  end
end