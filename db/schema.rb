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

ActiveRecord::Schema.define(version: 20170807094221) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "pharmacies", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "address"
    t.string "way"
    t.string "monday", array: true
    t.string "tuesday", array: true
    t.string "wednesday", array: true
    t.string "thursday", array: true
    t.string "friday", array: true
    t.string "saturday", array: true
    t.string "sunday", array: true
    t.string "holiday", array: true
    t.string "hpid"
    t.point "coordinates"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "info"
    t.index ["hpid"], name: "index_pharmacies_on_hpid", unique: true
  end

end
