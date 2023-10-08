# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 3) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "preferences", force: :cascade do |t|
    t.text "key", null: false
    t.text "value"
    t.bigint "user_id", null: false
    t.boolean "require_root", default: true, null: false, comment: "Require user to be root to change this setting"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "key"], name: "index_preferences_on_user_id_and_key", unique: true
    t.index ["user_id"], name: "index_preferences_on_user_id"
  end

  create_table "settings", force: :cascade do |t|
    t.text "key", null: false
    t.text "value"
    t.boolean "require_root", default: true, null: false, comment: "Require user to be root to change this setting"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_settings_on_key", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.text "fullname"
    t.text "username"
    t.text "email", null: false
    t.text "password_digest", null: false
    t.datetime "root_at", precision: nil
    t.integer "failed_attempts", default: 0, null: false
    t.text "enc_otp_key"
    t.datetime "locked_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true, where: "(username IS NOT NULL)"
  end

  add_foreign_key "preferences", "users"
end
