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

ActiveRecord::Schema.define(version: 20180312033438) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "lesson_assignments", force: :cascade do |t|
    t.bigint "lesson_id"
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["lesson_id"], name: "index_lesson_assignments_on_lesson_id"
    t.index ["role_id"], name: "index_lesson_assignments_on_role_id"
    t.index ["user_id"], name: "index_lesson_assignments_on_user_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.float "duration"
    t.integer "location_type"
    t.bigint "subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_id"], name: "index_lessons_on_subject_id"
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

  create_table "sessions", force: :cascade do |t|
    t.time "start_time"
    t.time "end_time"
    t.bigint "lesson_id"
    t.bigint "instructor_id"
    t.bigint "location_id"
    t.index ["instructor_id"], name: "index_sessions_on_instructor_id"
    t.index ["lesson_id"], name: "index_sessions_on_lesson_id"
  end

  create_table "sessions_users", force: :cascade do |t|
    t.bigint "student_id"
    t.bigint "session_id"
    t.index ["session_id"], name: "index_sessions_users_on_session_id"
    t.index ["student_id"], name: "index_sessions_users_on_student_id"
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
    t.string "avatar"
    t.string "slug"
    t.integer "pillar", default: 0
  end

end
