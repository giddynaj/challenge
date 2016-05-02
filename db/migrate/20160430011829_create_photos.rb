class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string    :url
      t.datetime  :taken_at
    end
    add_index :photos, :taken_at
  end
end
