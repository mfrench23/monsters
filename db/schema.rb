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

ActiveRecord::Schema.define(version: 20150312002649) do

  create_table "attacks", force: :cascade do |t|
    t.integer  "monster_id",  limit: 4
    t.string   "name",        limit: 255
    t.string   "skill",       limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "attacks", ["monster_id"], name: "index_attacks_on_monster_id", using: :btree

  create_table "books", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "abbreviation", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "damage_resistances", force: :cascade do |t|
    t.integer  "monster_id",  limit: 4
    t.integer  "location_id", limit: 4
    t.integer  "dr",          limit: 4
    t.text     "notes",       limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "damage_resistances", ["location_id"], name: "index_damage_resistances_on_location_id", using: :btree
  add_index "damage_resistances", ["monster_id"], name: "index_damage_resistances_on_monster_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "monster_classes", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "monster_names", force: :cascade do |t|
    t.integer  "monster_id", limit: 4
    t.boolean  "primary",    limit: 1
    t.string   "name",       limit: 255
    t.text     "notes",      limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "monster_names", ["monster_id"], name: "index_monster_names_on_monster_id", using: :btree

  create_table "monsters", force: :cascade do |t|
    t.integer  "strength",         limit: 4
    t.integer  "dexterity",        limit: 4
    t.integer  "intelligence",     limit: 4
    t.integer  "health",           limit: 4
    t.integer  "hitPoints",        limit: 4
    t.integer  "will",             limit: 4
    t.integer  "perception",       limit: 4
    t.integer  "fatigue",          limit: 4
    t.integer  "sizeModifier",     limit: 4
    t.string   "height",           limit: 255
    t.string   "weight",           limit: 255
    t.text     "gear",             limit: 65535
    t.text     "description",      limit: 65535
    t.text     "notes",            limit: 65535
    t.integer  "dodge",            limit: 4
    t.integer  "block",            limit: 4
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.decimal  "speed",                          precision: 4, scale: 2
    t.integer  "monster_class_id", limit: 4
  end

  add_index "monsters", ["monster_class_id"], name: "index_monsters_on_monster_class_id", using: :btree

  create_table "movement_rates", force: :cascade do |t|
    t.integer  "monster_id",      limit: 4
    t.integer  "terrain_type_id", limit: 4
    t.integer  "rate",            limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "movement_rates", ["monster_id"], name: "index_movement_rates_on_monster_id", using: :btree
  add_index "movement_rates", ["terrain_type_id"], name: "index_movement_rates_on_terrain_type_id", using: :btree

  create_table "page_references", force: :cascade do |t|
    t.integer  "book_id",    limit: 4
    t.integer  "monster_id", limit: 4
    t.string   "pages",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "page_references", ["book_id"], name: "index_page_references_on_book_id", using: :btree
  add_index "page_references", ["monster_id"], name: "index_page_references_on_monster_id", using: :btree

  create_table "parry_scores", force: :cascade do |t|
    t.string   "weapon",        limit: 255
    t.integer  "parry",         limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "monster_id_id", limit: 4
    t.integer  "monster_id",    limit: 4
  end

  add_index "parry_scores", ["monster_id"], name: "index_parry_scores_on_monster_id", using: :btree
  add_index "parry_scores", ["monster_id_id"], name: "index_parry_scores_on_monster_id_id", using: :btree

  create_table "skills", force: :cascade do |t|
    t.integer  "monster_id", limit: 4
    t.string   "name",       limit: 255
    t.string   "trait",      limit: 255
    t.integer  "modifier",   limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "skills", ["monster_id"], name: "index_skills_on_monster_id", using: :btree

  create_table "terrain_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "traits", force: :cascade do |t|
    t.integer  "monster_id",  limit: 4
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.boolean  "is_feature",  limit: 1
    t.integer  "level",       limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "traits", ["monster_id"], name: "index_traits_on_monster_id", using: :btree

  add_foreign_key "attacks", "monsters"
  add_foreign_key "damage_resistances", "locations"
  add_foreign_key "damage_resistances", "locations"
  add_foreign_key "damage_resistances", "monsters"
  add_foreign_key "monster_names", "monsters"
  add_foreign_key "monsters", "monster_classes"
  add_foreign_key "movement_rates", "monsters"
  add_foreign_key "movement_rates", "terrain_types"
  add_foreign_key "page_references", "books"
  add_foreign_key "page_references", "monsters"
  add_foreign_key "parry_scores", "monsters"
  add_foreign_key "skills", "monsters"
  add_foreign_key "traits", "monsters"
end
