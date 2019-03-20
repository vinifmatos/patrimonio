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

ActiveRecord::Schema.define(version: 2019_03_20_001440) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "departments", force: :cascade do |t|
    t.string "description"
    t.bigint "property_id", null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_departments_on_property_id"
  end

  create_table "financial_movement_kinds", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "financial_movements", force: :cascade do |t|
    t.bigint "good_id", null: false
    t.date "date", null: false
    t.decimal "amount", precision: 15, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "financial_movement_kind_id", null: false
    t.integer "code", null: false
    t.decimal "depreciated_amount", precision: 15, scale: 2, default: "0.0", null: false
    t.decimal "net_amount", precision: 15, scale: 2, null: false
    t.index ["financial_movement_kind_id"], name: "index_financial_movements_on_financial_movement_kind_id"
    t.index ["good_id", "code"], name: "index_financial_movements_on_good_id_and_code", unique: true
    t.index ["good_id"], name: "index_financial_movements_on_good_id"
  end

  create_table "good_categories", force: :cascade do |t|
    t.string "description"
    t.boolean "active", default: true, null: false
    t.bigint "good_sub_kind_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["good_sub_kind_id"], name: "index_good_categories_on_good_sub_kind_id"
  end

  create_table "good_kinds", force: :cascade do |t|
    t.string "description"
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "good_situations", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "good_sub_kinds", force: :cascade do |t|
    t.string "description"
    t.boolean "active", default: true, null: false
    t.bigint "good_kind_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "lifespan", null: false
    t.float "residual_amount_rate", null: false
    t.float "yearly_depreciation_rate", null: false
    t.integer "depreciation_method", null: false
    t.index ["good_kind_id"], name: "index_good_sub_kinds_on_good_kind_id"
  end

  create_table "goods", force: :cascade do |t|
    t.integer "code", null: false
    t.string "description", null: false
    t.text "specification"
    t.decimal "purchase_price", precision: 15, scale: 2, null: false
    t.date "purchase_date", null: false
    t.date "base_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "good_category_id", null: false
    t.bigint "department_id", null: false
    t.bigint "good_situation_id", null: false
    t.decimal "residual_amount", precision: 15, scale: 2, null: false
    t.decimal "depreciable_amount", precision: 15, scale: 2, null: false
    t.integer "depreciation_method", null: false
    t.date "last_depreciation"
    t.decimal "depreciated_amount", precision: 15, scale: 2, default: "0.0", null: false
    t.decimal "net_amount", precision: 15, scale: 2, null: false
    t.index ["code"], name: "index_goods_on_code", unique: true
    t.index ["department_id"], name: "index_goods_on_department_id"
    t.index ["good_category_id"], name: "index_goods_on_good_category_id"
    t.index ["good_situation_id"], name: "index_goods_on_good_situation_id"
  end

  create_table "movement_kinds", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movements", force: :cascade do |t|
    t.bigint "good_id", null: false
    t.bigint "department_id", null: false
    t.date "date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "movement_kind_id", null: false
    t.integer "code", null: false
    t.index ["department_id"], name: "index_movements_on_department_id"
    t.index ["good_id", "code"], name: "index_movements_on_good_id_and_code", unique: true
    t.index ["good_id"], name: "index_movements_on_good_id"
    t.index ["movement_kind_id"], name: "index_movements_on_movement_kind_id"
  end

  create_table "properties", force: :cascade do |t|
    t.string "description"
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "departments", "properties"
  add_foreign_key "financial_movements", "financial_movement_kinds"
  add_foreign_key "financial_movements", "goods"
  add_foreign_key "good_categories", "good_sub_kinds"
  add_foreign_key "good_sub_kinds", "good_kinds"
  add_foreign_key "goods", "departments"
  add_foreign_key "goods", "good_categories"
  add_foreign_key "goods", "good_situations"
  add_foreign_key "movements", "departments"
  add_foreign_key "movements", "goods"
  add_foreign_key "movements", "movement_kinds"
end
