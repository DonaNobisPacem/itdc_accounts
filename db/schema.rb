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

ActiveRecord::Schema.define(version: 20161124032315) do

  create_table "account_transactions", force: :cascade do |t|
    t.integer  "transaction_type", limit: 4
    t.decimal  "amount",                         precision: 15, scale: 2
    t.decimal  "prev_balance",                   precision: 15, scale: 2
    t.decimal  "new_balance",                    precision: 15, scale: 2
    t.text     "description",      limit: 65535
    t.integer  "account_id",       limit: 4
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
  end

  add_index "account_transactions", ["account_id"], name: "index_account_transactions_on_account_id", using: :btree

  create_table "account_types", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "accounts", force: :cascade do |t|
    t.integer  "account_type",     limit: 4
    t.decimal  "beginning_amount",           precision: 15, scale: 2
    t.decimal  "balance",                    precision: 15, scale: 2
    t.integer  "user_id",          limit: 4
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
  end

  add_index "accounts", ["user_id"], name: "index_accounts_on_user_id", using: :btree

  create_table "announcements", force: :cascade do |t|
    t.string   "subject",           limit: 255
    t.text     "message",           limit: 65535
    t.boolean  "visible_to_users"
    t.boolean  "visible_to_admins"
    t.datetime "start_date"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "transaction_types", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.string   "provider",               limit: 255
    t.string   "uid",                    limit: 255
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.string   "image",                  limit: 255
    t.boolean  "admin",                              default: false
    t.boolean  "validated",                          default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "account_transactions", "accounts"
  add_foreign_key "accounts", "users"
end
