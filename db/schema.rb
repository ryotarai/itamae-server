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

ActiveRecord::Schema.define(version: 20150813063000) do

  create_table "executions", force: :cascade do |t|
    t.integer  "revision_id", limit: 4
    t.integer  "status",      limit: 4, default: 0
    t.boolean  "is_dry_run"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "executions", ["revision_id"], name: "index_executions_on_revision_id", using: :btree

  create_table "host_executions", force: :cascade do |t|
    t.string   "host",         limit: 255
    t.integer  "status",       limit: 4,   default: 0
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "execution_id", limit: 4
  end

  add_index "host_executions", ["execution_id"], name: "index_host_executions_on_execution_id", using: :btree

  create_table "revisions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string   "key",         limit: 255
    t.string   "value",       limit: 255
    t.integer  "target_id",   limit: 4
    t.string   "target_type", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "tags", ["target_type", "target_id"], name: "index_tags_on_target_type_and_target_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_foreign_key "executions", "revisions"
  add_foreign_key "host_executions", "executions"
end
