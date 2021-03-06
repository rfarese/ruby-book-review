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

ActiveRecord::Schema.define(version: 20160721164304) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: :cascade do |t|
    t.integer "user_id",     null: false
    t.string  "title",       null: false
    t.string  "author",      null: false
    t.text    "description", null: false
    t.string  "cover_photo"
  end

  create_table "ranks", force: :cascade do |t|
    t.integer "book_id", null: false
    t.integer "user_id", null: false
    t.integer "score",   null: false
  end

  add_index "ranks", ["user_id", "book_id"], name: "index_ranks_on_user_id_and_book_id", unique: true, using: :btree

  create_table "reviews", force: :cascade do |t|
    t.integer "book_id",     null: false
    t.integer "user_id",     null: false
    t.string  "title",       null: false
    t.text    "description", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",             default: "",       null: false
    t.string   "last_name",              default: "",       null: false
    t.string   "email",                  default: "",       null: false
    t.string   "encrypted_password",     default: "",       null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,        null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "role",                   default: "member", null: false
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer "review_id",                 null: false
    t.integer "user_id",                   null: false
    t.boolean "up_vote",   default: false, null: false
    t.boolean "down_vote", default: false, null: false
  end

  add_index "votes", ["user_id", "review_id"], name: "index_votes_on_user_id_and_review_id", unique: true, using: :btree

end
