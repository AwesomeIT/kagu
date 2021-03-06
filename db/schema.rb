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

ActiveRecord::Schema.define(version: 20170727194201) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "experiments", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name",       default: "",    null: false
    t.integer  "repeats",    default: 0,     null: false
    t.boolean  "active",     default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "replays",    default: 0,     null: false
    t.index ["user_id"], name: "index_experiments_on_user_id", using: :btree
  end

  create_table "experiments_samples", force: :cascade do |t|
    t.integer "sample_id"
    t.integer "experiment_id"
    t.index ["experiment_id"], name: "index_experiments_samples_on_experiment_id", using: :btree
    t.index ["sample_id"], name: "index_experiments_samples_on_sample_id", using: :btree
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer  "resource_owner_id", null: false
    t.integer  "application_id",    null: false
    t.string   "token",             null: false
    t.integer  "expires_in",        null: false
    t.text     "redirect_uri",      null: false
    t.datetime "created_at",        null: false
    t.datetime "revoked_at"
    t.string   "scopes"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",                               null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",                          null: false
    t.string   "scopes"
    t.string   "previous_refresh_token", default: "", null: false
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string   "name",                      null: false
    t.string   "uid",                       null: false
    t.string   "secret",                    null: false
    t.text     "redirect_uri",              null: false
    t.string   "scopes",       default: "", null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "user_id"
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree
    t.index ["user_id"], name: "index_oauth_applications_on_user_id", using: :btree
  end

  create_table "organization_mappings", force: :cascade do |t|
    t.string  "kindable_type"
    t.integer "kindable_id"
    t.integer "organization_id"
    t.index ["kindable_id", "kindable_type"], name: "index_organization_mappings_on_kindable_id_and_kindable_type", using: :btree
    t.index ["kindable_type", "kindable_id"], name: "index_organization_mappings_on_kindable_type_and_kindable_id", using: :btree
    t.index ["organization_id", "kindable_type", "kindable_id"], name: "org_maps_org_id_kindable_unique", unique: true, using: :btree
    t.index ["organization_id"], name: "index_organization_mappings_on_organization_id", using: :btree
  end

  create_table "organizations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_organizations_on_name", unique: true, using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["name"], name: "index_roles_on_name", unique: true, using: :btree
  end

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "role_id"
    t.integer "user_id"
    t.index ["role_id"], name: "index_roles_users_on_role_id", using: :btree
    t.index ["user_id"], name: "index_roles_users_on_user_id", using: :btree
  end

  create_table "samples", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name",       default: "", null: false
    t.string   "s3_key",     default: "", null: false
    t.string   "low_label"
    t.string   "high_label"
    t.string   "hypothesis"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["s3_key"], name: "index_samples_on_s3_key", unique: true, using: :btree
    t.index ["user_id"], name: "index_samples_on_user_id", using: :btree
  end

  create_table "scores", force: :cascade do |t|
    t.integer "user_id"
    t.integer "sample_id"
    t.integer "experiment_id"
    t.integer "rating",        default: 0, null: false
    t.index ["experiment_id"], name: "index_scores_on_experiment_id", using: :btree
    t.index ["sample_id"], name: "index_scores_on_sample_id", using: :btree
    t.index ["user_id"], name: "index_scores_on_user_id", using: :btree
  end

  create_table "tag_mappings", force: :cascade do |t|
    t.string  "kindable_type"
    t.integer "kindable_id"
    t.integer "tag_id"
    t.index ["kindable_id", "tag_id"], name: "index_tag_mappings_on_kindable_id_and_tag_id", unique: true, using: :btree
    t.index ["kindable_type", "kindable_id"], name: "index_tag_mappings_on_kindable_type_and_kindable_id", using: :btree
    t.index ["tag_id"], name: "index_tag_mappings_on_tag_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.integer  "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "experiments", "users"
  add_foreign_key "experiments_samples", "experiments"
  add_foreign_key "experiments_samples", "samples"
  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_applications", "users"
  add_foreign_key "organization_mappings", "organizations"
  add_foreign_key "roles_users", "roles"
  add_foreign_key "roles_users", "users"
  add_foreign_key "samples", "users"
  add_foreign_key "scores", "experiments"
  add_foreign_key "scores", "samples"
  add_foreign_key "scores", "users"
  add_foreign_key "tag_mappings", "tags"
end
