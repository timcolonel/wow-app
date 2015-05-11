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

ActiveRecord::Schema.define(version: 20150511141444) do

  create_table "package_authors", force: :cascade do |t|
    t.integer  "package_id", limit: 4
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "package_authors", ["package_id"], name: "index_package_authors_on_package_id", using: :btree

  create_table "package_platforms", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "parent_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "package_platforms", ["parent_id"], name: "index_package_platforms_on_parent_id", using: :btree

  create_table "package_versions", force: :cascade do |t|
    t.string   "version",     limit: 255
    t.integer  "package_id",  limit: 4
    t.integer  "platform_id", limit: 4
    t.string   "link",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "package_versions", ["package_id"], name: "index_package_versions_on_package_id", using: :btree
  add_index "package_versions", ["platform_id"], name: "index_package_versions_on_platform_id", using: :btree

  create_table "packages", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.text     "short_description", limit: 65535
    t.text     "description",       limit: 65535
    t.string   "homepage",          limit: 255
    t.integer  "user_id",           limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "packages", ["user_id"], name: "index_packages_on_user_id", using: :btree

  create_table "packages_tags", force: :cascade do |t|
    t.integer  "package_id", limit: 4
    t.integer  "tag_id",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
