class Photo < ActiveRecord::Base
  has_many :brands, :through => :brand_memberships
  has_many :brand_memberships
  has_one  :favorited

def self.get_photos_of_brand(id, page = 0, limit = 75)
  margin = page.to_i * limit 
  offset = 0 + margin
  Brand.find(id).photos.limit(limit).offset(offset)
end
def self.get_counts_of_brand(id)
  Brand.find(id).photos.count
end
end

