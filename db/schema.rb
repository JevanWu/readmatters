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

ActiveRecord::Schema.define(version: 20150207141156) do

  create_table "carts", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", force: true do |t|
    t.string   "name"
    t.integer  "province_id"
    t.integer  "level"
    t.string   "zip_code"
    t.string   "pinyin"
    t.string   "pinyin_abbr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cities", ["level"], name: "index_cities_on_level"
  add_index "cities", ["name"], name: "index_cities_on_name"
  add_index "cities", ["pinyin"], name: "index_cities_on_pinyin"
  add_index "cities", ["pinyin_abbr"], name: "index_cities_on_pinyin_abbr"
  add_index "cities", ["province_id"], name: "index_cities_on_province_id"
  add_index "cities", ["zip_code"], name: "index_cities_on_zip_code"

  create_table "districts", force: true do |t|
    t.string   "name"
    t.integer  "city_id"
    t.string   "pinyin"
    t.string   "pinyin_abbr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "districts", ["city_id"], name: "index_districts_on_city_id"
  add_index "districts", ["name"], name: "index_districts_on_name"
  add_index "districts", ["pinyin"], name: "index_districts_on_pinyin"
  add_index "districts", ["pinyin_abbr"], name: "index_districts_on_pinyin_abbr"

  create_table "line_items", force: true do |t|
    t.integer  "quantity",   default: 1
    t.integer  "order_id"
    t.integer  "cart_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "line_items", ["cart_id"], name: "index_line_items_on_cart_id"
  add_index "line_items", ["order_id"], name: "index_line_items_on_order_id"
  add_index "line_items", ["product_id"], name: "index_line_items_on_product_id"

  create_table "orders", force: true do |t|
    t.string   "receiver_name"
    t.integer  "province_id"
    t.integer  "city_id"
    t.integer  "district_id"
    t.string   "street"
    t.integer  "user_id"
    t.integer  "receiver_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["city_id"], name: "index_orders_on_city_id"
  add_index "orders", ["district_id"], name: "index_orders_on_district_id"
  add_index "orders", ["province_id"], name: "index_orders_on_province_id"
  add_index "orders", ["receiver_id"], name: "index_orders_on_receiver_id"
  add_index "orders", ["user_id"], name: "index_orders_on_user_id"

  create_table "products", force: true do |t|
    t.string   "name"
    t.string   "kind"
    t.decimal  "price"
    t.text     "description"
    t.boolean  "sold"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "products", ["user_id"], name: "index_products_on_user_id"

  create_table "provinces", force: true do |t|
    t.string   "name"
    t.string   "pinyin"
    t.string   "pinyin_abbr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "provinces", ["name"], name: "index_provinces_on_name"
  add_index "provinces", ["pinyin"], name: "index_provinces_on_pinyin"
  add_index "provinces", ["pinyin_abbr"], name: "index_provinces_on_pinyin_abbr"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "occupation"
    t.integer  "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
