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

ActiveRecord::Schema.define(version: 20151207104325) do

  create_table "events", force: :cascade do |t|
    t.integer  "execution_id", limit: 4
    t.integer  "host_id",      limit: 4
    t.string   "event_type",   limit: 255
    t.text     "payload",      limit: 65535
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "events", ["execution_id"], name: "index_events_on_execution_id", using: :btree
  add_index "events", ["host_id"], name: "index_events_on_host_id", using: :btree

  create_table "executions", force: :cascade do |t|
    t.integer  "revision_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "executions", ["revision_id"], name: "index_executions_on_revision_id", using: :btree

  create_table "host_executions", force: :cascade do |t|
    t.integer  "host_id",      limit: 4
    t.integer  "execution_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "host_executions", ["execution_id"], name: "index_host_executions_on_execution_id", using: :btree
  add_index "host_executions", ["host_id"], name: "index_host_executions_on_host_id", using: :btree

  create_table "hosts", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "hosts", ["name"], name: "index_hosts_on_name", using: :btree

  create_table "revisions", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "url",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_foreign_key "events", "executions"
  add_foreign_key "events", "hosts"
  add_foreign_key "executions", "revisions"
  add_foreign_key "host_executions", "executions"
  add_foreign_key "host_executions", "hosts"
end
