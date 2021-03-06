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

ActiveRecord::Schema.define(version: 20150522123045) do

  create_table "badges", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "points"
    t.string   "img_link"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "problem_tags", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "problem_id"
    t.integer  "tag_id"
  end

  add_index "problem_tags", ["problem_id"], name: "index_problem_tags_on_problem_id"
  add_index "problem_tags", ["tag_id"], name: "index_problem_tags_on_tag_id"

  create_table "problems", force: :cascade do |t|
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "title"
    t.string   "unique_name"
    t.string   "description"
    t.integer  "user_id"
    t.integer  "set_id"
    t.integer  "rating",      default: 0
  end

  add_index "problems", ["user_id"], name: "index_problems_on_user_id"

  create_table "solution_tags", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "solution_id"
    t.integer  "tag_id"
  end

  add_index "solution_tags", ["solution_id"], name: "index_solution_tags_on_solution_id"
  add_index "solution_tags", ["tag_id"], name: "index_solution_tags_on_tag_id"

  create_table "solutions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "rating",     default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "problem_id"
    t.string   "content"
  end

  add_index "solutions", ["problem_id"], name: "index_solutions_on_problem_id"
  add_index "solutions", ["user_id"], name: "index_solutions_on_user_id"

  create_table "tags", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
    t.string   "category"
  end

  create_table "user_badges", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "badge_id"
  end

  add_index "user_badges", ["badge_id"], name: "index_user_badges_on_badge_id"
  add_index "user_badges", ["user_id"], name: "index_user_badges_on_user_id"

  create_table "user_infos", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "category"
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_infos", ["user_id"], name: "index_user_infos_on_user_id"

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "rating"
    t.string   "name"
    t.string   "email"
    t.string   "group"
  end

end
