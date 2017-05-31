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

ActiveRecord::Schema.define(version: 20170531075119) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", id: :serial, force: :cascade do |t|
    t.string "namespace", limit: 255
    t.text "body"
    t.string "resource_id", limit: 255, null: false
    t.string "resource_type", limit: 255, null: false
    t.integer "author_id"
    t.string "author_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", id: :serial, force: :cascade do |t|
    t.string "email", limit: 255, default: "", null: false
    t.string "encrypted_password", limit: 255, default: "", null: false
    t.string "reset_password_token", limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip", limit: 255
    t.string "last_sign_in_ip", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "books", id: :serial, force: :cascade do |t|
    t.string "isbn", limit: 255
    t.string "name", limit: 255
    t.string "tags", limit: 255
    t.decimal "price"
    t.text "summary"
    t.string "author", limit: 255
    t.text "author_intro"
    t.text "catalog"
    t.string "original_cover", limit: 255
    t.string "publisher", limit: 255
    t.date "published_date"
    t.string "cover_file_name", limit: 255
    t.string "cover_content_type", limit: 255
    t.integer "cover_file_size"
    t.datetime "cover_updated_at"
    t.json "raw_data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "hq_cover"
    t.decimal "rating"
    t.integer "num_of_raters"
  end

  create_table "carts", id: :serial, force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "cities", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "province_id"
    t.integer "level"
    t.string "zip_code", limit: 255
    t.string "pinyin", limit: 255
    t.string "pinyin_abbr", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["level"], name: "index_cities_on_level"
    t.index ["name"], name: "index_cities_on_name"
    t.index ["pinyin"], name: "index_cities_on_pinyin"
    t.index ["pinyin_abbr"], name: "index_cities_on_pinyin_abbr"
    t.index ["province_id"], name: "index_cities_on_province_id"
    t.index ["zip_code"], name: "index_cities_on_zip_code"
  end

  create_table "conversations", id: :serial, force: :cascade do |t|
    t.integer "recipient_id"
    t.integer "sender_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipient_id", "sender_id"], name: "index_conversations_on_recipient_id_and_sender_id", unique: true
    t.index ["recipient_id"], name: "index_conversations_on_recipient_id"
    t.index ["sender_id"], name: "index_conversations_on_sender_id"
  end

  create_table "districts", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "city_id"
    t.string "pinyin", limit: 255
    t.string "pinyin_abbr", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["city_id"], name: "index_districts_on_city_id"
    t.index ["name"], name: "index_districts_on_name"
    t.index ["pinyin"], name: "index_districts_on_pinyin"
    t.index ["pinyin_abbr"], name: "index_districts_on_pinyin_abbr"
  end

  create_table "line_items", id: :serial, force: :cascade do |t|
    t.integer "quantity", default: 1
    t.integer "order_id"
    t.integer "cart_id"
    t.integer "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["cart_id"], name: "index_line_items_on_cart_id"
    t.index ["order_id"], name: "index_line_items_on_order_id"
    t.index ["product_id"], name: "index_line_items_on_product_id"
  end

  create_table "messages", id: :serial, force: :cascade do |t|
    t.text "body"
    t.datetime "read_at"
    t.integer "user_id"
    t.integer "conversation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "orders", id: :serial, force: :cascade do |t|
    t.string "identifier", limit: 255
    t.string "state", limit: 255
    t.integer "province_id"
    t.integer "city_id"
    t.integer "district_id"
    t.string "street", limit: 255
    t.string "receiver_name", limit: 255
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "seller_id"
    t.decimal "total_price"
    t.string "pay_code", limit: 255
    t.string "receiver_phone"
    t.index ["city_id"], name: "index_orders_on_city_id"
    t.index ["district_id"], name: "index_orders_on_district_id"
    t.index ["province_id"], name: "index_orders_on_province_id"
    t.index ["seller_id"], name: "index_orders_on_seller_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "photos", id: :serial, force: :cascade do |t|
    t.integer "product_id"
    t.text "description"
    t.string "image_file_name", limit: 255
    t.string "image_content_type", limit: 255
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["product_id"], name: "index_photos_on_product_id"
  end

  create_table "products", id: :serial, force: :cascade do |t|
    t.string "tags", limit: 255
    t.decimal "price"
    t.text "summary"
    t.string "cover_file_name", limit: 255
    t.string "cover_content_type", limit: 255
    t.integer "cover_file_size"
    t.datetime "cover_updated_at"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "status", limit: 255, default: "initial"
    t.integer "book_id"
    t.index ["book_id"], name: "index_products_on_book_id"
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "provinces", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "pinyin", limit: 255
    t.string "pinyin_abbr", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "index_provinces_on_name"
    t.index ["pinyin"], name: "index_provinces_on_pinyin"
    t.index ["pinyin_abbr"], name: "index_provinces_on_pinyin_abbr"
  end

  create_table "taggings", force: :cascade do |t|
    t.bigint "tag_id"
    t.string "taggable_type"
    t.bigint "taggable_id"
    t.string "tagger_type"
    t.bigint "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type", "taggable_id"], name: "index_taggings_on_taggable_type_and_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
    t.index ["tagger_type", "tagger_id"], name: "index_taggings_on_tagger_type_and_tagger_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "occupation", limit: 255
    t.string "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "email", limit: 255, default: "", null: false
    t.string "encrypted_password", limit: 255, default: "", null: false
    t.string "reset_password_token", limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip", limit: 255
    t.string "last_sign_in_ip", limit: 255
    t.string "avatar_file_name", limit: 255
    t.string "avatar_content_type", limit: 255
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string "confirmation_token", limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email", limit: 255
    t.string "current_location"
    t.string "personal_link"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_votes_on_book_id"
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

  add_foreign_key "messages", "conversations"
  add_foreign_key "messages", "users"
end
