require 'test_helper'
 
class BrandTest < ActiveSupport::TestCase
   test "brand test counts" do
     brands = Brand.get_all_with_counts
     assert brands['Adidas'] == {:id=>1, :counts=>"9"}, "Adidas record not equal to {:id=>1, :counts=>\"9\"}"
     assert brands['Marc_Jacobs'] == {:id=>2, :counts=>"1"}, "Marc_Jacobs record not equal to {:id=>2, :counts=>\"9\"}"
   end

   test "get neighbors" do
     neighbors = Brand.find(1).get_neighbors
     assert neighbors == [{:id=>5, :brand_name=>"John_Hancock", :counts=>"2"}], "#{neighbors} not equal to 145"
   end

   test "get count" do
     count = Brand.get_count
     assert count == 145, "#{count} not equal to 145"
   end

   test "exists?" do
     exist = Brand.exists?('Adidas')
     assert exist == true, "Adidas does not exist."
     exist = Brand.exists?('Adixdas')
     assert exist == false, "Adixdas exists? It should not!"
   end
  
end
