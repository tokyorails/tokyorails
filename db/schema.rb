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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111203121725) do

  create_table "images", :force => true do |t|
    t.integer  "member_id"
    t.string   "file_uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "images", ["member_id"], :name => "index_images_on_member_id"

  create_table "members", :force => true do |t|
    t.string   "meetup_id"
    t.string   "name"
    t.string   "bio"
    t.string   "github_username"
    t.string   "photo_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "members", ["meetup_id"], :name => "index_members_on_meetup_id"

end
