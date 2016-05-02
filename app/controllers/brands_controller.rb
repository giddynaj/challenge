class BrandsController < ApplicationController 
layout "welcome"

def index
if request.format.json?
render :json => Photo.get_photos_of_brand(params[:id],params[:page]).to_json(:include =>{:brand_memberships => { :only => :match_quality }, :favorited => {:only => :favorited}})
else
@photos = Photo.get_photos_of_brand(params[:id],0).to_json(:include =>{:brand_memberships => { :only => :match_quality }, :favorited => {:only => :favorited}})
@brand_name = Brand.find(params[:id]).brand_name
@photo_count = Photo.get_counts_of_brand(params[:id])
@brand_neighbors = Brand.find(params[:id]).get_neighbors
end
end
end
