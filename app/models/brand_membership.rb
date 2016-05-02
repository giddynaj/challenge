class BrandMembership < ActiveRecord::Base
  belongs_to :brand
  belongs_to :photo
end
