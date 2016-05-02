# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160430012920) do

  create_table "brand_memberships", force: :cascade do |t|
    t.integer "photo_id",      limit: 4
    t.integer "brand_id",      limit: 4
    t.string  "match_quality", limit: 255
  end

  add_index "brand_memberships", ["brand_id"], name: "index_brand_memberships_on_brand_id", using: :btree
  add_index "brand_memberships", ["photo_id"], name: "index_brand_memberships_on_photo_id", using: :btree

  create_table "brands", force: :cascade do |t|
    t.string "brand_name", limit: 255
  end

  create_table "favoriteds", force: :cascade do |t|
    t.integer "photo_id",  limit: 4
    t.string  "media",     limit: 255
    t.integer "favorited", limit: 4
  end

  add_index "favoriteds", ["photo_id"], name: "index_favoriteds_on_photo_id", using: :btree

  create_table "photos", force: :cascade do |t|
    t.string   "url",      limit: 255
    t.datetime "taken_at"
  end

  add_index "photos", ["taken_at"], name: "index_photos_on_taken_at", using: :btree

end
