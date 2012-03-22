module Rifffz
  module Sluggable
    module ClassMethods
      def sluggable(field)
        before_save { |record| update_slug(field) }
      end
    end
    
    def self.included(base)
      base.extend ClassMethods
    end
    
    def update_slug(field)
      self.slug = self.attributes[field.to_s].downcase
                      .gsub(/\s+/, '-')     # replace spaces with -
                      .gsub(/[^\w\-]+/, '') # remove all non-word chars
                      .gsub(/\-\-+/, '-')   # replace multiple - with single -
                      .gsub(/^-+/, '')      # trim - from start of text
                      .gsub(/-+$/, '')      # trim - from end of text
    end
  end
end
