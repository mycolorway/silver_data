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

ActiveRecord::Schema.define(version: 20170313214517) do

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "departments", force: :cascade do |t|
    t.string   "name"
    t.integer  "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_departments_on_company_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string   "name"
    t.date     "joined_at"
    t.date     "regularized_at"
    t.integer  "department_id"
    t.string   "phone"
    t.decimal  "salary",         precision: 10, scale: 2
    t.integer  "company_id"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.index ["company_id"], name: "index_employees_on_company_id"
    t.index ["department_id"], name: "index_employees_on_department_id"
  end

  create_table "form_fields", force: :cascade do |t|
    t.string   "name"
    t.string   "title"
    t.string   "hint"
    t.string   "data_type"
    t.string   "input_type"
    t.string   "default_value"
    t.text     "input_options"
    t.integer  "form_group_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["form_group_id"], name: "index_form_fields_on_form_group_id"
  end

  create_table "form_groups", force: :cascade do |t|
    t.string   "title"
    t.text     "options"
    t.integer  "form_id"
    t.integer  "form_field_id"
    t.string   "ancestry"
    t.string   "type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["ancestry"], name: "index_form_groups_on_ancestry"
    t.index ["form_field_id"], name: "index_form_groups_on_form_field_id"
    t.index ["form_id"], name: "index_form_groups_on_form_id"
  end

  create_table "forms", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "company_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["company_id"], name: "index_forms_on_company_id"
  end

end
