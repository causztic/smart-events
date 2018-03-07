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

ActiveRecord::Schema.define(version: 20180307095156) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "lesson_assignments", force: :cascade do |t|
    t.bigint "lesson_id"
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["lesson_id"], name: "index_lesson_assignments_on_lesson_id"
    t.index ["role_id"], name: "index_lesson_assignments_on_role_id"
    t.index ["user_id"], name: "index_lesson_assignments_on_user_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.string "subject"
    t.float "duration"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "location"
    t.integer "location_type"
    t.integer "students"
    t.bigint "subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_id"], name: "index_lessons_on_subject_id"
  end

  create_table "lessons_users", id: false, force: :cascade do |t|
    t.bigint "lesson_id"
    t.bigint "instructor_id"
    t.index ["instructor_id"], name: "index_lessons_users_on_instructor_id"
    t.index ["lesson_id"], name: "index_lessons_users_on_lesson_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.string "roomname"
    t.string "classroom"
    t.integer "capacity"
    t.string "locate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "code", null: false
    t.string "name"
    t.string "description"
    t.float "hours_per_week"
    t.json "facility_hours"
    t.float "minimum_hours_per_lesson"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "term_available"
    t.integer "pillar", default: 5
    t.index ["code"], name: "index_subjects_on_code", unique: true
  end

  create_table "subjects_users", id: false, force: :cascade do |t|
    t.bigint "subject_id"
    t.bigint "instructor_id"
    t.bigint "student_id"
    t.index ["instructor_id"], name: "index_subjects_users_on_instructor_id"
    t.index ["student_id"], name: "index_subjects_users_on_student_id"
    t.index ["subject_id"], name: "index_subjects_users_on_subject_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "type"
    t.string "email"
    t.string "password_digest"
    t.string "name"
    t.string "designation"
    t.string "faculty"
    t.string "research_area"
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

end
