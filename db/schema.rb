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

ActiveRecord::Schema.define(version: 20150512101053) do

  create_table "logs", force: :cascade do |t|
    t.string   "host",       limit: 255
    t.integer  "status",     limit: 4,   default: 0
    t.string   "file_path",  limit: 255
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "plan_id",    limit: 4
  end

  add_index "logs", ["plan_id"], name: "index_logs_on_plan_id", using: :btree

  create_table "plans", force: :cascade do |t|
    t.integer  "revision_id", limit: 4
    t.integer  "status",      limit: 4, default: 0
    t.boolean  "is_dry_run",  limit: 1
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "plans", ["revision_id"], name: "index_plans_on_revision_id", using: :btree

  create_table "revisions", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "file_path",  limit: 255
  end

  add_foreign_key "logs", "plans"
  add_foreign_key "plans", "revisions"
end
