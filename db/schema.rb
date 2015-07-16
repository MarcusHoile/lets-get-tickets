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

ActiveRecord::Schema.define(version: 20150714110638) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string   "what",        limit: 255
    t.text     "description"
    t.string   "where",       limit: 255
    t.integer  "price"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "lat"
    t.decimal  "lng"
    t.string   "status",      limit: 255, default: "open"
    t.string   "image",       limit: 255
    t.boolean  "booked",                  default: false
    t.datetime "deadline"
    t.datetime "when"
    t.integer  "limited"
    t.boolean  "demo"
  end

  add_index "events", ["user_id"], name: "index_events_on_user_id", using: :btree

  create_table "invites", force: :cascade do |t|
    t.string   "rsvp",           limit: 255, default: "undecided"
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "payment",                    default: false
    t.string   "reason",         limit: 255
    t.string   "payment_method", limit: 255
  end

  add_index "invites", ["event_id"], name: "index_invites_on_event_id", using: :btree
  add_index "invites", ["user_id"], name: "index_invites_on_user_id", using: :btree

  create_table "media", force: :cascade do |t|
    t.string   "url",        limit: 255
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "media_type", limit: 255
    t.string   "source_id",  limit: 255
  end

  add_index "media", ["event_id"], name: "index_media_on_event_id", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.boolean  "active",                 default: true
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",       limit: 255
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider",         limit: 255
    t.string   "uid",              limit: 255
    t.string   "name",             limit: 255
    t.string   "email",            limit: 255
    t.string   "oauth_token",      limit: 255
    t.datetime "oauth_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image",            limit: 255
    t.boolean  "guest_user"
    t.boolean  "demo"
  end

end
