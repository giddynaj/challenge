class Brand < ActiveRecord::Base
  has_many :photos, :through => :brand_memberships
  has_many :brand_memberships
  attr_accessor :name


  def self.get_all_with_counts
    names_with_counts = {} 
    brands = self.all
    name_counts = RedisConnection.hgetall("brands")
    brands.each do |brand|
      names_with_counts[brand['brand_name']] = { id: brand['id'], counts: name_counts["#{brand['brand_name']}:result"]}
    end
    names_with_counts
  end

  def get_neighbors
    neighbors = RedisConnection.hgetall(self.brand_name)
    neighbors.sort_by{ |k,v| -v.to_i}[0,3].map do |neighbor|
    brand =  Brand.find_by_brand_name(neighbor[0].split(":")[0])
    { id: brand.id, brand_name: brand.brand_name, counts: neighbor[1] }
    end
  end

  def self.get_count
    self.count
  end

  def exists?(name)
    !self.find_by_name(name).empty?
  end
end
