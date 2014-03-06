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
    num = 0
    slug_name = alt_name
    slugs = Category.all.map {|p| p.slug}
    while slugs.include?(slug_name)
      num = num + 1 
      slug_name = alt_name + '-' + num.to_s
    end
    self.slug = slug_name
  end

end