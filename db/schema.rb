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

ActiveRecord::Schema.define(version: 20170520144243) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "requests", force: :cascade do |t|
    t.integer  "service_id"
    t.string   "language"
    t.text     "details"
    t.integer  "user_id"
    t.integer  "assigned_mentor_id"
    t.integer  "requested_mentor_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["assigned_mentor_id"], name: "index_requests_on_assigned_mentor_id", using: :btree
    t.index ["requested_mentor_id"], name: "index_requests_on_requested_mentor_id", using: :btree
    t.index ["service_id"], name: "index_requests_on_service_id", using: :btree
    t.index ["user_id"], name: "index_requests_on_user_id", using: :btree
  end

  create_table "services", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "squads", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "leader_id"
    t.integer  "minimum"
    t.integer  "maximum"
    t.string   "skill_level"
    t.text     "activities"
    t.text     "end_condition"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["leader_id"], name: "index_squads_on_leader_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "zip"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.boolean  "mentor",                 default: false
    t.string   "slack_name"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "timezone"
    t.text     "bio"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "requests", "users"
end
