class Category < ActiveRecord::Base
  has_many :post_categories
  has_many :posts, through: :post_categories

  validates :name, presence: true, uniqueness: true

  after_validation :generate_slug!

  def to_param
    self.slug
  end

  def generate_slug!
    alt_name = self.name.strip.gsub(/\W/,'-').downcase
    alt_name.gsub!(/-+/, '-')   
    slug_name = alt_name
    num = 0
    while !!Category.find_by(slug: slug_name)
      num = num + 1 
      slug_name = alt_name + '-' + num.to_s
    end
    self.slug = slug_name
  end
end