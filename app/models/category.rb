class Category < ActiveRecord::Base
  has_many :post_categories
  has_many :posts, through: :post_categories

  validates :name, presence: true, uniqueness: true

  after_validation :generate_slug

  def to_param
    self.slug
  end

  def generate_slug
    self.slug = self.name.downcase.gsub(/\W/, '-')
  end

end