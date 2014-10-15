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

ActiveRecord::Schema.define(version: 20141015124705) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contacts", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "body"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.datetime "event_when"
    t.string   "what"
    t.text     "description"
    t.string   "where"
    t.datetime "on_sale"
    t.integer  "price"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "lat"
    t.decimal  "lng"
    t.string   "status",      default: "open"
    t.boolean  "ticket",      default: false
    t.string   "image"
  end

  add_index "events", ["user_id"], name: "index_events_on_user_id", using: :btree

  create_table "friendships", force: true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invites", force: true do |t|
    t.string   "rsvp",           default: "Undecided"
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "payment",        default: false
    t.string   "reason"
    t.string   "payment_method"
  end

  add_index "invites", ["event_id"], name: "index_invites_on_event_id", using: :btree
  add_index "invites", ["user_id"], name: "index_invites_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "email"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.boolean  "guest_user"
  end

end
