class Comment < ActiveRecord::Base
  include VoteableJake

  belongs_to :post
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'

  validates :body, length: {minimum: 5}
end