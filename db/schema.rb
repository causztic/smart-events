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

ActiveRecord::Schema.define(version: 20180401095240) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chat_rooms", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "speaker_name"
    t.float "duration"
    t.date "date"
    t.time "start_time"
    t.time "end_time"
    t.integer "pillar"
    t.bigint "location_id"
    t.index ["location_id"], name: "index_events_on_location_id"
  end

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

  create_table "messages", force: :cascade do |t|
    t.string "content"
    t.bigint "chat_room_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_room_id"], name: "index_messages_on_chat_room_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "lesson_id"
    t.bigint "instructor_id"
    t.bigint "location_id"
    t.bigint "subject_id"
    t.integer "day", default: 0
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer "session_group", default: 0
    t.index ["instructor_id"], name: "index_sessions_on_instructor_id"
    t.index ["lesson_id"], name: "index_sessions_on_lesson_id"
    t.index ["subject_id"], name: "index_sessions_on_subject_id"
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
    t.jsonb "facility_hours"
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
    t.jsonb "preferences"
  end

  add_foreign_key "events", "locations"
  add_foreign_key "messages", "chat_rooms"
  add_foreign_key "messages", "users"
  add_foreign_key "sessions", "subjects"
end
