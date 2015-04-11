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

ActiveRecord::Schema.define(version: 20150411101949) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "keywords", force: :cascade do |t|
    t.integer  "report_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "keywords", ["report_id"], name: "index_keywords_on_report_id", using: :btree

  create_table "reports", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "reports", ["user_id"], name: "index_reports_on_user_id", using: :btree

  create_table "search_result_urls", force: :cascade do |t|
    t.integer  "search_result_id"
    t.integer  "url_type_id"
    t.string   "url"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "search_result_urls", ["search_result_id"], name: "index_search_result_urls_on_search_result_id", using: :btree
  add_index "search_result_urls", ["url_type_id"], name: "index_search_result_urls_on_url_type_id", using: :btree

  create_table "search_results", force: :cascade do |t|
    t.integer  "keyword_id"
    t.integer  "top_ads_count"
    t.integer  "right_ads_count"
    t.integer  "total_ads_count"
    t.integer  "non_ads_count"
    t.integer  "total_link"
    t.string   "keyword_result"
    t.text     "html_code"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "search_results", ["keyword_id"], name: "index_search_results_on_keyword_id", using: :btree

  create_table "url_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "keywords", "reports"
  add_foreign_key "reports", "users"
  add_foreign_key "search_result_urls", "search_results"
  add_foreign_key "search_result_urls", "url_types"
  add_foreign_key "search_results", "keywords"
end
