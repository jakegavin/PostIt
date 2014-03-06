class Post < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :votes, as: :voteable

  validates :title, presence: true, length: {minimum: 5}
  validates :description, presence: true, length: {maximum: 500}
  validates :url, presence: true, uniqueness: true

  after_validation :generate_slug!

  def total_votes
    up_votes - down_votes
  end

  def up_votes
    self.votes.where(vote: true).size
  end

  def down_votes
    self.votes.where(vote: false).size
  end

  def to_param
    self.slug
  end

  def generate_slug!
    alt_title = self.title.strip.gsub(/\W/,'-').downcase
    alt_title.gsub!(/-+/, '-')   
    num = 0
    slug_title = alt_title
    slugs = Post.all.map {|p| p.slug}
    while slugs.include?(slug_title)
      num = num + 1 
      slug_title = alt_title + '-' + num.to_s
    end
    self.slug = slug_title
  end
end