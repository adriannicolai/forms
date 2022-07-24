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

ActiveRecord::Schema[7.0].define(version: 2022_07_24_014856) do
  create_table "form_questions", charset: "utf8", force: :cascade do |t|
    t.bigint "form_id", null: false
    t.bigint "form_section_id"
    t.integer "question_type_id", limit: 2
    t.string "title"
    t.text "choices_json"
    t.integer "is_required", limit: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["form_id"], name: "index_form_questions_on_form_id"
    t.index ["form_section_id"], name: "index_form_questions_on_form_section_id"
  end

  create_table "form_sections", charset: "utf8", force: :cascade do |t|
    t.bigint "form_id", null: false
    t.text "form_question_ids"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["form_id"], name: "index_form_sections_on_form_id"
  end

  create_table "forms", charset: "utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title", limit: 150
    t.string "description", limit: 500
    t.text "form_settings_json"
    t.integer "cache_response_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_forms_on_user_id"
  end

  create_table "users", charset: "utf8", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "form_questions", "form_sections"
  add_foreign_key "form_questions", "forms"
  add_foreign_key "form_sections", "forms"
  add_foreign_key "forms", "users"
end
