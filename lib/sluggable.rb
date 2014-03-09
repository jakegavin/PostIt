module Sluggable
  extend ActiveSupport::Concern

  included do    
    after_validation :generate_slug!
    class_attribute :slug_column
  end

  def to_param
    self.slug
  end

  def generate_slug!
    alt_title = self.send(self.class.slug_column.to_sym).strip.gsub(/\W/,'-').downcase
    alt_title.gsub!(/-+/, '-')   
    slug = alt_title
    num = 0
    while !!self.class.find_by(slug: slug)
      num += 1
      slug = alt_title + '-' + num.to_s
    end
    self.slug = slug
  end

  module ClassMethods
    def sluggable_column(column_name)
      self.slug_column = column_name
    end
  end
end