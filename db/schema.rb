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

ActiveRecord::Schema.define(version: 2020_12_06_004101) do

  create_table "leads", force: :cascade do |t|
    t.string "name", limit: 20
  end

  create_table "marketings", force: :cascade do |t|
    t.string "content"
    t.integer "result", limit: 1
    t.integer "source_id", null: false
    t.integer "product_id", null: false
    t.integer "lead_id", null: false
    t.string "time", limit: 25
    t.index ["lead_id"], name: "index_marketings_on_lead_id"
    t.index ["product_id"], name: "index_marketings_on_product_id"
    t.index ["source_id"], name: "index_marketings_on_source_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", limit: 15
  end

  create_table "sale_leads", force: :cascade do |t|
    t.string "name", limit: 20
  end

  create_table "sales", force: :cascade do |t|
    t.string "customer", limit: 30, null: false
    t.integer "sale_lead_id", null: false
    t.integer "product_id", null: false
    t.string "demand"
    t.string "connection", null: false
    t.integer "status_id", null: false
    t.string "email", limit: 50
    t.string "phone", limit: 20
    t.string "time", limit: 25
    t.string "modified_time", limit: 25
    t.index ["product_id"], name: "index_sales_on_product_id"
    t.index ["sale_lead_id"], name: "index_sales_on_sale_lead_id"
    t.index ["status_id"], name: "index_sales_on_status_id"
  end

  create_table "sources", force: :cascade do |t|
    t.string "name", limit: 20
  end

  create_table "statuses", force: :cascade do |t|
    t.string "name", limit: 20
  end

  create_table "users", force: :cascade do |t|
    t.string "username", limit: 20
    t.string "email", limit: 50
    t.string "password"
    t.string "name", limit: 30
    t.string "avatar"
    t.string "roles", limit: 30
  end

  add_foreign_key "marketings", "leads"
  add_foreign_key "marketings", "products"
  add_foreign_key "marketings", "sources"
  add_foreign_key "sales", "products"
  add_foreign_key "sales", "sale_leads"
  add_foreign_key "sales", "statuses"
end
