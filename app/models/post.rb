class Post < ActiveRecord::Base
  include Voteable

  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories

  validates :title, presence: true, length: {minimum: 5}
  validates :description, presence: true, length: {maximum: 500}
  validates :url, presence: true, uniqueness: true

  after_validation :generate_slug!

  def to_param
    self.slug
  end

  def generate_slug!
    alt_title = self.title.strip.gsub(/\W/,'-').downcase
    alt_title.gsub!(/-+/, '-')   
    slug_title = alt_title
    num = 0
    while !!Post.find_by(slug: slug_title)
      num += 1
      slug_title = alt_title + '-' + num.to_s
    end
    self.slug = slug_title
  end
end