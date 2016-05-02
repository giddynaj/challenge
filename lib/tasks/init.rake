require 'pry'
require 'json'
require 'date'
namespace :init do
  desc "TODO"
  task load_data: :environment do
     File.open(Rails.root.join(*%w( tmp bostonmarathon_photos.json )), 'r') do |f|
       f.each_line do |line|
         p = JSON.parse(line)

         photo = Photo.create(:url => p['matches']['url'], :taken_at => Time.at(p['post']['created_time'].to_i).to_datetime)
         # TODO should consider storing different size image urls

         p['matches']['data']['matches'].each do |brand_instance|
           brand = Brand.find_or_create_by(:brand_name => brand_instance['brand'])
           RedisConnection.hincrby("brands", "#{brand_instance['brand']}:result", 1)
           BrandMembership.create(:photo_id => photo.id, :brand_id => brand.id, :match_quality => brand_instance['match_quality'])
           p['matches']['data']['matches'].each do |neighbor|
             if brand_instance['brand'] != neighbor['brand']
               RedisConnection.hincrby(brand_instance['brand'], "#{neighbor['brand']}:result", 1)
             end
           end
         end
   
         

         Favorited.create(:photo_id => photo.id, :media => 'instagram', :favorited => p['post']['likes']['count'])

       end
     end
  end

end
