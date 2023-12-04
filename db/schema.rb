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

ActiveRecord::Schema[7.0].define(version: 19) do
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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "image_to_records", force: :cascade do |t|
    t.bigint "image_id", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["image_id"], name: "index_image_to_records_on_image_id"
    t.index ["record_type", "record_id", "image_id"], name: "index_image_to_records_on_record_and_image", unique: true
    t.index ["record_type", "record_id"], name: "index_image_to_records_on_record"
  end

  create_table "images", force: :cascade do |t|
    t.text "filename", null: false
    t.text "status", null: false
    t.text "tag", comment: "Internal tag for image. A tag may be 'blur', 'thumbnail', ... May be nil when is original image."
    t.bigint "original_id"
    t.jsonb "other", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["filename"], name: "index_images_on_filename"
    t.index ["original_id"], name: "index_images_on_original_id"
    t.index ["tag", "original_id"], name: "index_images_on_tag_and_original_id", unique: true, where: "(original_id IS NOT NULL)"
  end

  create_table "menu_allergens", force: :cascade do |t|
    t.text "status", null: false
    t.jsonb "other", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "menu_allergens_in_dishes", force: :cascade do |t|
    t.bigint "menu_dish_id", null: false
    t.bigint "menu_allergen_id", null: false
    t.integer "index", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_allergen_id"], name: "index_menu_allergens_in_dishes_on_menu_allergen_id"
    t.index ["menu_dish_id", "index"], name: "index_menu_allergens_in_dishes_on_menu_dish_id_and_index", unique: true
    t.index ["menu_dish_id", "menu_allergen_id"], name: "index_menu_allergens_in_dishes_on_dish_and_allergen", unique: true
    t.index ["menu_dish_id"], name: "index_menu_allergens_in_dishes_on_menu_dish_id"
  end

  create_table "menu_categories", force: :cascade do |t|
    t.text "status", null: false
    t.integer "index", null: false
    t.text "secret", null: false
    t.text "secret_desc"
    t.jsonb "other", default: {}, null: false
    t.float "price"
    t.bigint "parent_id"
    t.bigint "menu_visibility_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["index", "parent_id"], name: "index_menu_categories_on_index_and_parent_id", unique: true
    t.index ["menu_visibility_id"], name: "index_menu_categories_on_menu_visibility_id"
    t.index ["parent_id"], name: "index_menu_categories_on_parent_id"
    t.index ["secret"], name: "index_menu_categories_on_secret"
    t.index ["secret_desc"], name: "index_menu_categories_on_secret_desc", where: "(secret_desc IS NOT NULL)"
  end

  create_table "menu_dishes", force: :cascade do |t|
    t.text "status", null: false
    t.integer "price", comment: "The price of the dish. Can be null or 0 some cases, for example when the dish is inside a category with a fixed price."
    t.jsonb "other", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "menu_dishes_in_categories", force: :cascade do |t|
    t.bigint "menu_dish_id", null: false
    t.bigint "menu_category_id", null: false
    t.bigint "menu_visibility_id", null: false
    t.integer "index", null: false, comment: "Index of the element in the list. Starts at 0."
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["index", "menu_category_id"], name: "index_menu_dishes_in_categories_on_index_and_menu_category_id", unique: true
    t.index ["index"], name: "index_menu_dishes_in_categories_on_index"
    t.index ["menu_category_id"], name: "index_menu_dishes_in_categories_on_menu_category_id"
    t.index ["menu_dish_id"], name: "index_menu_dishes_in_categories_on_menu_dish_id"
    t.index ["menu_visibility_id"], name: "index_menu_dishes_in_categories_on_menu_visibility_id"
  end

  create_table "menu_ingredients", force: :cascade do |t|
    t.text "status", null: false
    t.jsonb "other", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "menu_ingredients_in_dishes", force: :cascade do |t|
    t.bigint "menu_dish_id", null: false
    t.bigint "menu_ingredient_id", null: false
    t.integer "index", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_dish_id", "index"], name: "index_menu_ingredients_in_dishes_on_menu_dish_id_and_index", unique: true
    t.index ["menu_dish_id", "menu_ingredient_id"], name: "index_menu_ingredients_in_dishes_on_dish_and_ingredient", unique: true
    t.index ["menu_dish_id"], name: "index_menu_ingredients_in_dishes_on_menu_dish_id"
    t.index ["menu_ingredient_id"], name: "index_menu_ingredients_in_dishes_on_menu_ingredient_id"
  end

  create_table "menu_tags", force: :cascade do |t|
    t.text "color", null: false
    t.text "status", null: false
    t.jsonb "other", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "menu_tags_in_dishes", force: :cascade do |t|
    t.bigint "menu_dish_id", null: false
    t.bigint "menu_tag_id", null: false
    t.integer "index", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_dish_id", "index"], name: "index_menu_tags_in_dishes_on_menu_dish_id_and_index", unique: true
    t.index ["menu_dish_id", "menu_tag_id"], name: "index_menu_tags_in_dishes_on_dish_and_tag", unique: true
    t.index ["menu_dish_id"], name: "index_menu_tags_in_dishes_on_menu_dish_id"
    t.index ["menu_tag_id"], name: "index_menu_tags_in_dishes_on_menu_tag_id"
  end

  create_table "menu_visibilities", force: :cascade do |t|
    t.boolean "public_visible", default: false, null: false
    t.datetime "public_from", precision: nil
    t.datetime "public_to", precision: nil
    t.boolean "private_visible", default: false, null: false
    t.datetime "private_from", precision: nil
    t.datetime "private_to", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mobility_string_translations", force: :cascade do |t|
    t.string "locale", null: false
    t.string "key", null: false
    t.string "value"
    t.string "translatable_type"
    t.bigint "translatable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["translatable_id", "translatable_type", "key"], name: "index_mobility_string_translations_on_translatable_attribute"
    t.index ["translatable_id", "translatable_type", "locale", "key"], name: "index_mobility_string_translations_on_keys", unique: true
    t.index ["translatable_type", "key", "value", "locale"], name: "index_mobility_string_translations_on_query_keys"
  end

  create_table "mobility_text_translations", force: :cascade do |t|
    t.string "locale", null: false
    t.string "key", null: false
    t.text "value"
    t.string "translatable_type"
    t.bigint "translatable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["translatable_id", "translatable_type", "key"], name: "index_mobility_text_translations_on_translatable_attribute"
    t.index ["translatable_id", "translatable_type", "locale", "key"], name: "index_mobility_text_translations_on_keys", unique: true
  end

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

  create_table "refresh_tokens", force: :cascade do |t|
    t.text "secret", null: false
    t.datetime "expires_at", precision: nil, null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["secret"], name: "index_refresh_tokens_on_secret"
    t.index ["user_id"], name: "index_refresh_tokens_on_user_id"
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
    t.text "status", null: false
    t.datetime "root_at", precision: nil
    t.integer "failed_attempts", default: 0, null: false
    t.text "enc_otp_key"
    t.datetime "locked_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true, where: "(username IS NOT NULL)"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "image_to_records", "images"
  add_foreign_key "images", "images", column: "original_id"
  add_foreign_key "menu_allergens_in_dishes", "menu_allergens"
  add_foreign_key "menu_allergens_in_dishes", "menu_dishes"
  add_foreign_key "menu_categories", "menu_visibilities"
  add_foreign_key "menu_ingredients_in_dishes", "menu_dishes"
  add_foreign_key "menu_ingredients_in_dishes", "menu_ingredients"
  add_foreign_key "menu_tags_in_dishes", "menu_dishes"
  add_foreign_key "menu_tags_in_dishes", "menu_tags"
  add_foreign_key "preferences", "users"
  add_foreign_key "refresh_tokens", "users"
end
