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

ActiveRecord::Schema.define(version: 20170921171503) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "answers", force: :cascade do |t|
    t.integer  "submission_id"
    t.integer  "question_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "choice"
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id", using: :btree
  add_index "answers", ["submission_id"], name: "index_answers_on_submission_id", using: :btree

  create_table "brands", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "color_a"
    t.string   "color_b"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "brands", ["user_id"], name: "index_brands_on_user_id", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "matrices", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.string   "body"
    t.integer  "matrix_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "area"
  end

  add_index "questions", ["matrix_id"], name: "index_questions_on_matrix_id", using: :btree

  create_table "submissions", force: :cascade do |t|
    t.integer  "matrix_id"
    t.integer  "user_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "name"
    t.string   "export_file_name"
    t.string   "export_content_type"
    t.integer  "export_file_size"
    t.datetime "export_updated_at"
    t.string   "s3_url"
    t.hstore   "top_line_current_hash"
    t.hstore   "top_line_target_hash"
    t.hstore   "answers"
    t.hstore   "targets"
  end

  add_index "submissions", ["answers"], name: "index_submissions_on_answers", using: :gin
  add_index "submissions", ["matrix_id"], name: "index_submissions_on_matrix_id", using: :btree
  add_index "submissions", ["targets"], name: "index_submissions_on_targets", using: :gin
  add_index "submissions", ["top_line_current_hash"], name: "index_submissions_on_top_line_current_hash", using: :gin
  add_index "submissions", ["top_line_target_hash"], name: "index_submissions_on_top_line_target_hash", using: :gin
  add_index "submissions", ["user_id"], name: "index_submissions_on_user_id", using: :btree

  create_table "targets", force: :cascade do |t|
    t.string   "choice"
    t.integer  "question_id"
    t.integer  "submission_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "targets", ["question_id"], name: "index_targets_on_question_id", using: :btree
  add_index "targets", ["submission_id"], name: "index_targets_on_submission_id", using: :btree

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.boolean  "admin"
    t.boolean  "paid"
    t.string   "card_token"
    t.string   "organisation"
    t.string   "organisation_size"
    t.string   "organisation_turnover"
    t.string   "digital_size"
    t.boolean  "opt_in"
    t.string   "api_key"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "submissions"
  add_foreign_key "brands", "users"
  add_foreign_key "questions", "matrices"
  add_foreign_key "submissions", "matrices"
  add_foreign_key "submissions", "users"
  add_foreign_key "targets", "questions"
  add_foreign_key "targets", "submissions"
end
