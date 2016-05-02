class CreateBrand < ActiveRecord::Migration
  def change
    create_table :brands do |t|
       t.string :brand_name
    end
  end
end
