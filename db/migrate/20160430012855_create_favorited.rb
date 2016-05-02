class CreateFavorited < ActiveRecord::Migration
  def change
    create_table :favoriteds do |t|
      t.integer :photo_id
      t.string :media
      t.integer :favorited
    end
    add_index :favoriteds, :photo_id
  end
end
