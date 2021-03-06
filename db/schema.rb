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

ActiveRecord::Schema.define(version: 2019_07_10_200847) do

  create_table "books", force: :cascade do |t|
    t.string "title"
  end

  create_table "comments", force: :cascade do |t|
    t.integer "forum_id"
    t.string "contributions"
    t.integer "user_id"
  end

  create_table "forums", force: :cascade do |t|
    t.integer "book_id"
    t.string "forum_title"
    t.string "content"
  end

  create_table "memberships", force: :cascade do |t|
    t.integer "user_id"
    t.integer "forum_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
  end

end
