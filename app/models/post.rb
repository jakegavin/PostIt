class Post < ActiveRecord::Base
  include VoteableJake
  include Sluggable

  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories

  validates :title, presence: true, length: {minimum: 5}
  validates :description, presence: true, length: {maximum: 500}
  validates :url, presence: true, uniqueness: true

  sluggable_column :title

  def to_json(options)
    super(:except => [:id, :slug])
  end

  def to_xml(options)
    super(:except => [:id, :slug])
  end
end