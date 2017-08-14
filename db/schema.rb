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

ActiveRecord::Schema.define(version: 20170809164559) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "url"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.boolean  "scholarship_available"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "requests", force: :cascade do |t|
    t.integer  "service_id"
    t.string   "language"
    t.text     "details"
    t.integer  "user_id"
    t.integer  "assigned_mentor_id"
    t.integer  "requested_mentor_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "status"
    t.index ["assigned_mentor_id"], name: "index_requests_on_assigned_mentor_id", using: :btree
    t.index ["requested_mentor_id"], name: "index_requests_on_requested_mentor_id", using: :btree
    t.index ["service_id"], name: "index_requests_on_service_id", using: :btree
    t.index ["user_id"], name: "index_requests_on_user_id", using: :btree
  end

  create_table "resources", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.string   "category"
    t.string   "language"
    t.boolean  "paid"
    t.text     "notes"
    t.integer  "votes_count", default: 0, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "scholarship_applications", force: :cascade do |t|
    t.text     "reason"
    t.boolean  "terms_accpeted"
    t.integer  "user_id"
    t.integer  "scholarship_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["scholarship_id"], name: "index_scholarship_applications_on_scholarship_id", using: :btree
    t.index ["user_id"], name: "index_scholarship_applications_on_user_id", using: :btree
  end

  create_table "scholarships", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "location"
    t.text     "terms"
    t.datetime "open_time"
    t.datetime "close_time"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "services", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "squad_members", force: :cascade do |t|
    t.integer  "squad_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["squad_id", "user_id"], name: "index_squad_members_on_squad_id_and_user_id", unique: true, using: :btree
    t.index ["squad_id"], name: "index_squad_members_on_squad_id", using: :btree
    t.index ["user_id"], name: "index_squad_members_on_user_id", using: :btree
  end

  create_table "squad_mentors", force: :cascade do |t|
    t.integer  "squad_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["squad_id", "user_id"], name: "index_squad_mentors_on_squad_id_and_user_id", unique: true, using: :btree
    t.index ["squad_id"], name: "index_squad_mentors_on_squad_id", using: :btree
    t.index ["user_id"], name: "index_squad_mentors_on_user_id", using: :btree
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

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.string   "taggable_type"
    t.integer  "taggable_id"
    t.string   "tagger_type"
    t.integer  "tagger_id"
    t.string   "context",       limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context", using: :btree
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
    t.index ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy", using: :btree
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id", using: :btree
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type", using: :btree
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type", using: :btree
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
  end

  create_table "team_members", force: :cascade do |t|
    t.string   "name"
    t.string   "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "zip"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "encrypted_password",              default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.boolean  "mentor",                          default: false
    t.string   "slack_name"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "timezone"
    t.text     "bio"
    t.boolean  "verified",                        default: false, null: false
    t.string   "state"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "username"
    t.boolean  "volunteer",                       default: false
    t.string   "branch_of_service"
    t.float    "years_of_service"
    t.string   "pay_grade"
    t.string   "military_occupational_specialty"
    t.string   "github"
    t.string   "twitter"
    t.string   "linkedin"
    t.string   "employment_status"
    t.string   "education"
    t.string   "company_role"
    t.string   "company_name"
    t.string   "education_level"
    t.string   "interests"
    t.boolean  "scholarship_info",                default: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "resource_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["resource_id"], name: "index_votes_on_resource_id", using: :btree
    t.index ["user_id"], name: "index_votes_on_user_id", using: :btree
  end

  add_foreign_key "requests", "users"
  add_foreign_key "scholarship_applications", "scholarships"
  add_foreign_key "scholarship_applications", "users"
  add_foreign_key "squad_members", "squads"
  add_foreign_key "squad_members", "users"
  add_foreign_key "squad_mentors", "squads"
  add_foreign_key "squad_mentors", "users"
  add_foreign_key "votes", "resources"
  add_foreign_key "votes", "users"
end
