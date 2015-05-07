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

ActiveRecord::Schema.define(version: 20150507104741) do

  create_table "package_authors", force: true do |t|
    t.integer  "package_id"
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "package_authors", ["package_id"], name: "index_package_authors_on_package_id", using: :btree

  create_table "package_platforms", force: true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "package_platforms", ["parent_id"], name: "index_package_platforms_on_parent_id", using: :btree

  create_table "package_versions", force: true do |t|
    t.string   "version"
    t.integer  "package_id"
    t.integer  "platform_id"
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "package_versions", ["package_id"], name: "index_package_versions_on_package_id", using: :btree
  add_index "package_versions", ["platform_id"], name: "index_package_versions_on_platform_id", using: :btree

  create_table "packages", force: true do |t|
    t.string   "name"
    t.text     "short_description"
    t.text     "description"
    t.string   "homepage"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "packages", ["user_id"], name: "index_package_packages_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
