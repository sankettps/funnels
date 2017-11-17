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

ActiveRecord::Schema.define(version: 20171116145956) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "downsell_products", force: :cascade do |t|
    t.bigint "funnel_id"
    t.bigint "filter_shop_product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["filter_shop_product_id"], name: "index_downsell_products_on_filter_shop_product_id"
    t.index ["funnel_id"], name: "index_downsell_products_on_funnel_id"
  end

  create_table "filter_shop_attributes", force: :cascade do |t|
    t.bigint "shop_id"
    t.string "detail_type"
    t.string "detail_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shop_id"], name: "index_filter_shop_attributes_on_shop_id"
  end

  create_table "filter_shop_products", force: :cascade do |t|
    t.bigint "shop_id"
    t.string "product_id"
    t.string "title"
    t.string "handle"
    t.string "vendor"
    t.string "product_type"
    t.text "tags"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.index ["shop_id"], name: "index_filter_shop_products_on_shop_id"
  end

  create_table "funnel_products", force: :cascade do |t|
    t.bigint "filter_shop_product_id"
    t.bigint "funnel_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["filter_shop_product_id"], name: "index_funnel_products_on_filter_shop_product_id"
    t.index ["funnel_id"], name: "index_funnel_products_on_funnel_id"
  end

  create_table "funnel_reports", force: :cascade do |t|
    t.string "product_id"
    t.string "up_product_id"
    t.string "down_product_id"
    t.string "hf_action"
    t.string "cart_token"
    t.float "price"
    t.datetime "temp_date"
    t.bigint "shop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shop_id"], name: "index_funnel_reports_on_shop_id"
  end

  create_table "funnels", force: :cascade do |t|
    t.string "name"
    t.string "up_sell_title"
    t.string "down_sell_title"
    t.integer "down_sell_time_out"
    t.integer "down_sell_interval"
    t.boolean "is_display_desc"
    t.string "redirect_page"
    t.boolean "is_active"
    t.bigint "shop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shop_id"], name: "index_funnels_on_shop_id"
  end

  create_table "shops", force: :cascade do |t|
    t.string "shopify_domain", null: false
    t.string "shopify_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_products_cloned", default: false
    t.string "domain"
    t.string "email"
    t.string "currency_symbol"
    t.string "currency"
    t.boolean "is_products_clonning", default: false
    t.index ["shopify_domain"], name: "index_shops_on_shopify_domain", unique: true
  end

  create_table "upsell_products", force: :cascade do |t|
    t.bigint "funnel_id"
    t.bigint "filter_shop_product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["filter_shop_product_id"], name: "index_upsell_products_on_filter_shop_product_id"
    t.index ["funnel_id"], name: "index_upsell_products_on_funnel_id"
  end

  add_foreign_key "downsell_products", "filter_shop_products"
  add_foreign_key "downsell_products", "funnels"
  add_foreign_key "filter_shop_attributes", "shops"
  add_foreign_key "filter_shop_products", "shops"
  add_foreign_key "funnel_products", "filter_shop_products"
  add_foreign_key "funnel_products", "funnels"
  add_foreign_key "funnel_reports", "shops"
  add_foreign_key "funnels", "shops"
  add_foreign_key "upsell_products", "filter_shop_products"
  add_foreign_key "upsell_products", "funnels"
end
