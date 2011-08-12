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

ActiveRecord::Schema.define(:version => 20110812023621) do

  create_table "ad_groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ads", :force => true do |t|
    t.text     "contents"
    t.integer  "ad_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "advertisements", :force => true do |t|
    t.integer  "ad_id"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", :force => true do |t|
    t.string   "city"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "promos"
    t.text     "advertisements"
    t.boolean  "active",         :default => false
  end

  add_index "locations", ["city"], :name => "index_locations_on_city", :unique => true

  create_table "member_summaries", :force => true do |t|
    t.integer  "member_id"
    t.integer  "location_id"
    t.date     "date_of_birth"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "facebook_url"
    t.string   "telephone"
    t.string   "weight"
    t.string   "hair_color"
    t.string   "bust"
    t.string   "waist"
    t.string   "hips"
    t.string   "piercings"
    t.string   "tattoos"
    t.string   "first_concert"
    t.string   "last_concert"
    t.string   "favorite_song"
    t.string   "relationship_status"
    t.string   "favorite_sport"
    t.text     "talent",               :limit => 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "piercing_description", :limit => 255
    t.text     "tattoo_description",   :limit => 255
    t.string   "cell_phone"
    t.string   "address_more"
    t.integer  "height_feet"
    t.integer  "height_inches"
    t.string   "top_bands_1"
    t.string   "top_bands_2"
    t.string   "top_bands_3"
    t.text     "experience"
    t.string   "eyes"
    t.string   "eyes_other"
    t.string   "ethnicity"
    t.string   "ethnicity_other"
    t.boolean  "staffing",                            :default => true
  end

  add_index "member_summaries", ["location_id"], :name => "index_member_summaries_on_location_id"
  add_index "member_summaries", ["member_id"], :name => "index_member_summaries_on_member_id", :unique => true

  create_table "pictures", :force => true do |t|
    t.integer  "member_id"
    t.boolean  "approved"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "credit"
  end

  add_index "pictures", ["member_id"], :name => "index_pictures_on_member_id"

  create_table "ratings", :force => true do |t|
    t.integer  "member_id"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ratings", ["member_id"], :name => "index_ratings_on_member_id"

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "",        :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "",        :null => false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",                     :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "profile_name"
    t.string   "type"
    t.integer  "status",                              :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email_confirmation"
    t.string   "state",                               :default => "pending"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["profile_name"], :name => "index_users_on_profile_name", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
