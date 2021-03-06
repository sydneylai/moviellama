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

ActiveRecord::Schema.define(version: 20141109025619) do

  create_table "movies", force: true do |t|
    t.string   "title"
    t.integer  "year"
    t.date     "release_date"
    t.string   "genre"
    t.text     "poster_url",   limit: 1000
    t.text     "plot"
    t.integer  "runtime"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "oscars"
    t.string   "imdbid"
  end

  create_table "ratings", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "rating"
    t.string   "source"
    t.integer  "movie_id"
  end

  create_table "sources", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "url",        limit: 1000
    t.string   "name"
    t.integer  "movie_id"
    t.float    "price"
  end

end
