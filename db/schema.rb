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

ActiveRecord::Schema.define(version: 2019_03_12_154853) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "departments", force: :cascade do |t|
    t.string "description"
    t.bigint "property_id"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_departments_on_property_id"
  end

  create_table "financial_movements", force: :cascade do |t|
    t.bigint "good_id"
    t.date "date"
    t.integer "kind"
    t.decimal "amount", precision: 15, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["good_id"], name: "index_financial_movements_on_good_id"
  end

  create_table "good_categories", force: :cascade do |t|
    t.string "description"
    t.boolean "active"
    t.bigint "good_sub_kind_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["good_sub_kind_id"], name: "index_good_categories_on_good_sub_kind_id"
  end

  create_table "good_kinds", force: :cascade do |t|
    t.string "description"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "good_sub_kinds", force: :cascade do |t|
    t.string "description"
    t.boolean "active"
    t.bigint "good_kind_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["good_kind_id"], name: "index_good_sub_kinds_on_good_kind_id"
  end

  create_table "goods", force: :cascade do |t|
    t.integer "code"
    t.string "description"
    t.text "specification"
    t.integer "situation"
    t.decimal "purchase_price", precision: 15, scale: 2
    t.date "purchase_date"
    t.date "base_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "good_category_id"
    t.index ["good_category_id"], name: "index_goods_on_good_category_id"
  end

  create_table "movements", force: :cascade do |t|
    t.bigint "good_id"
    t.bigint "department_id"
    t.date "date"
    t.integer "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_movements_on_department_id"
    t.index ["good_id"], name: "index_movements_on_good_id"
  end

  create_table "properties", force: :cascade do |t|
    t.string "description"
    t.boolean "active"
    t.bigint "good_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["good_id"], name: "index_properties_on_good_id"
  end

  add_foreign_key "departments", "properties"
  add_foreign_key "financial_movements", "goods"
  add_foreign_key "good_categories", "good_sub_kinds"
  add_foreign_key "good_sub_kinds", "good_kinds"
  add_foreign_key "goods", "good_categories"
  add_foreign_key "movements", "departments"
  add_foreign_key "movements", "goods"
  add_foreign_key "properties", "goods"
end
