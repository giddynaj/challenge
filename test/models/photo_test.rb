require 'test_helper'
 
class PhotoTest < ActiveSupport::TestCase
   test "get photos of brand" do
     photos = Photo.get_photos_of_brand(50)
     assert photos.length == 3, "Number of photos of brand id 50 is not equal to 3"
     assert photos[0].url == "https://scontent.cdninstagram.com/t51.2885-15/s640x640/sh0.08/e35/11371142_900033463398694_1404937798_n.jpg?ig_cache_key=MTA1NDU2MTQ0MjkzMDIxNTc3Nw%3D%3D.2", "First photo of brand id 50 is not same"
     photos = Photo.get_photos_of_brand(6,0,15)
     assert photos.length == 15, "Pagination page 1 of photos is not returning test length of 15"
     photos = Photo.get_photos_of_brand(6,1,15)
     assert photos.length == 15, "Pagination page 2 of photos is not returning test length of 15"
   end

   test "get counts of brand" do
     photos = Photo.get_counts_of_brand(50)
     assert photos == 3, "Number of photos of brand id 50 is not equal to 3"
   end
end
