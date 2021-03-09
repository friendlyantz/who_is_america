# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_09_200724) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.integer "location_type"
    t.bigint "parent_location_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["parent_location_id"], name: "index_locations_on_parent_location_id"
  end

  create_table "politicians", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "party"
    t.bigint "location_id", null: false
    t.index ["location_id"], name: "index_politicians_on_location_id"
  end

  create_table "quotes", force: :cascade do |t|
    t.text "content", null: false
    t.text "source_link", null: false
    t.integer "approval_status", default: 0, null: false
    t.bigint "politician_id", null: false
    t.bigint "creator_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "parent_quote_id"
    t.bigint "source_tracker_id"
    t.index ["creator_id"], name: "index_quotes_on_creator_id"
    t.index ["parent_quote_id"], name: "index_quotes_on_parent_quote_id"
    t.index ["politician_id"], name: "index_quotes_on_politician_id"
    t.index ["source_tracker_id"], name: "index_quotes_on_source_tracker_id"
  end

  create_table "source_trackers", force: :cascade do |t|
    t.string "name"
    t.integer "reliability_by_admin", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_trackers", force: :cascade do |t|
    t.bigint "politician_id", null: false
    t.bigint "user_id", null: false
    t.float "match_ratio"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["politician_id"], name: "index_user_trackers_on_politician_id"
    t.index ["user_id"], name: "index_user_trackers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "permissions", default: 0, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.integer "content", null: false
    t.bigint "user_id", null: false
    t.bigint "quote_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["quote_id"], name: "index_votes_on_quote_id"
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "locations", "locations", column: "parent_location_id"
  add_foreign_key "politicians", "locations"
  add_foreign_key "quotes", "politicians"
  add_foreign_key "quotes", "quotes", column: "parent_quote_id"
  add_foreign_key "quotes", "source_trackers"
  add_foreign_key "quotes", "users", column: "creator_id"
  add_foreign_key "user_trackers", "politicians"
  add_foreign_key "user_trackers", "users"
  add_foreign_key "votes", "quotes"
  add_foreign_key "votes", "users"
end
