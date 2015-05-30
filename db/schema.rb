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

ActiveRecord::Schema.define(version: 20150530144044) do

  create_table "keys", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "token"
  end

  add_index "keys", ["token"], name: "index_keys_on_token", unique: true
  add_index "keys", ["user_id"], name: "index_keys_on_user_id"

  create_table "repositories", force: :cascade do |t|
    t.integer  "space_id"
    t.string   "name"
    t.string   "handle"
    t.integer  "created_by_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "repositories", ["handle"], name: "index_repositories_on_handle"
  add_index "repositories", ["space_id", "handle"], name: "index_repositories_on_space_id_and_handle", unique: true
  add_index "repositories", ["space_id"], name: "index_repositories_on_space_id"

  create_table "repository_users", force: :cascade do |t|
    t.integer  "repository_id"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "repository_users", ["repository_id", "user_id"], name: "index_repository_users_on_repository_id_and_user_id", unique: true

  create_table "spaces", force: :cascade do |t|
    t.string   "name"
    t.string   "handle"
    t.integer  "created_by_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "spaces", ["handle"], name: "index_spaces_on_handle", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "login"
    t.string   "email"
    t.integer  "created_by_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "token"
    t.boolean  "admin",         default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["login"], name: "index_users_on_login", unique: true
  add_index "users", ["token"], name: "index_users_on_token"

end
