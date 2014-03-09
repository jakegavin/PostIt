class User < ActiveRecord::Base
  include Sluggable

  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false
  
  validates :username, presence: true, uniqueness: true, format: {:with => /\A[\w\-]*\Z/}
  validates :password, length: { minimum: 5}, on: :create 
  
  sluggable_column :username
end