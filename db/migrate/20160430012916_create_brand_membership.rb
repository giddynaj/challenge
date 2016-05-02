class CreateBrandMembership < ActiveRecord::Migration
  def change
    create_table :brand_memberships do |t|
        t.integer :photo_id
        t.integer :brand_id
        t.string   :match_quality
    end
    add_index :brand_memberships, :photo_id
    add_index :brand_memberships, :brand_id
  end
end
