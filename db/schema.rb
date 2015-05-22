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

ActiveRecord::Schema.define(version: 20150522225126) do

  create_table "attacks", force: :cascade do |t|
    t.integer  "monster_id",  limit: 4
    t.string   "name",        limit: 255
    t.string   "skill",       limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "attacks", ["monster_id", "name"], name: "index_attacks_on_monster_id_and_name", unique: true, using: :btree
  add_index "attacks", ["monster_id"], name: "index_attacks_on_monster_id", using: :btree

  create_table "books", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "abbreviation", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "books", ["name"], name: "index_books_on_name", unique: true, using: :btree

  create_table "characteristic_monsters", force: :cascade do |t|
    t.integer  "characteristic_id", limit: 4
    t.integer  "monster_id",        limit: 4
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.decimal  "score",                       precision: 6, scale: 2
  end

  add_index "characteristic_monsters", ["characteristic_id", "monster_id"], name: "characteristic_monsters_uniq_join_table_idx", unique: true, using: :btree
  add_index "characteristic_monsters", ["characteristic_id"], name: "index_characteristic_monsters_on_characteristic_id", using: :btree
  add_index "characteristic_monsters", ["monster_id"], name: "index_characteristic_monsters_on_monster_id", using: :btree

  create_table "characteristics", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.integer  "sequence_number", limit: 4
    t.datetime "created_at",                                                        null: false
    t.datetime "updated_at",                                                        null: false
    t.decimal  "step_size",                   precision: 4, scale: 2, default: 1.0
    t.decimal  "base_value",                  precision: 6, scale: 2
  end

  add_index "characteristics", ["name"], name: "index_characteristics_on_name", unique: true, using: :btree
  add_index "characteristics", ["sequence_number"], name: "index_characteristics_on_sequence_number", unique: true, using: :btree

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

  create_table "illustrations", force: :cascade do |t|
    t.integer  "illustratable_id",   limit: 4
    t.string   "illustratable_type", limit: 255
    t.text     "notes",              limit: 65535
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
  end

  add_index "illustrations", ["illustratable_type", "illustratable_id"], name: "index_illustrations_on_illustratable_type_and_illustratable_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "locations", ["name"], name: "index_locations_on_name", unique: true, using: :btree

  create_table "master_skills", force: :cascade do |t|
    t.string   "name",                    limit: 255
    t.text     "notes",                   limit: 65535
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "characteristic_id",       limit: 4
    t.boolean  "requires_specialization", limit: 1
    t.boolean  "requires_tech_level",     limit: 1
  end

  add_index "master_skills", ["characteristic_id"], name: "index_master_skills_on_characteristic_id", using: :btree
  add_index "master_skills", ["name"], name: "index_master_skills_on_name", using: :btree

  create_table "master_traits", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.text     "notes",      limit: 65535
    t.boolean  "is_feature", limit: 1
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "master_traits", ["name"], name: "index_master_traits_on_name", using: :btree

  create_table "monster_classes", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "monster_classes", ["name"], name: "index_monster_classes_on_name", unique: true, using: :btree

  create_table "monster_names", force: :cascade do |t|
    t.integer  "monster_id", limit: 4
    t.string   "name",       limit: 255
    t.text     "notes",      limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "monster_names", ["monster_id"], name: "index_monster_names_on_monster_id", using: :btree
  add_index "monster_names", ["name"], name: "index_monster_names_on_name", using: :btree

  create_table "monsters", force: :cascade do |t|
    t.string   "height",            limit: 255
    t.string   "weight",            limit: 255
    t.text     "gear",              limit: 65535
    t.text     "description",       limit: 65535
    t.text     "notes",             limit: 65535
    t.integer  "dodge",             limit: 4
    t.integer  "block",             limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "monster_class_id",  limit: 4
    t.string   "name",              limit: 255
    t.integer  "parts_value_cents", limit: 4
  end

  add_index "monsters", ["monster_class_id"], name: "index_monsters_on_monster_class_id", using: :btree
  add_index "monsters", ["name"], name: "index_monsters_on_name", using: :btree

  create_table "move_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "move_types", ["name"], name: "index_move_types_on_name", unique: true, using: :btree

  create_table "movement_rates", force: :cascade do |t|
    t.integer  "monster_id",    limit: 4
    t.integer  "rate",          limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "move_type_id",  limit: 4
    t.integer  "enhanced_rate", limit: 4
  end

  add_index "movement_rates", ["monster_id"], name: "index_movement_rates_on_monster_id", using: :btree
  add_index "movement_rates", ["move_type_id"], name: "index_movement_rates_on_move_type_id", using: :btree

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
    t.integer  "monster_id",      limit: 4
    t.integer  "modifier",        limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "master_skill_id", limit: 4
    t.string   "specialization",  limit: 255
    t.string   "tech_level",      limit: 255
  end

  add_index "skills", ["master_skill_id"], name: "index_skills_on_master_skill_id", using: :btree
  add_index "skills", ["monster_id"], name: "index_skills_on_monster_id", using: :btree

  create_table "traits", force: :cascade do |t|
    t.integer  "monster_id",      limit: 4
    t.integer  "level",           limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "master_trait_id", limit: 4
  end

  add_index "traits", ["master_trait_id"], name: "index_traits_on_master_trait_id", using: :btree
  add_index "traits", ["monster_id"], name: "index_traits_on_monster_id", using: :btree

  add_foreign_key "attacks", "monsters"
  add_foreign_key "characteristic_monsters", "characteristics"
  add_foreign_key "characteristic_monsters", "monsters"
  add_foreign_key "damage_resistances", "locations"
  add_foreign_key "damage_resistances", "locations"
  add_foreign_key "damage_resistances", "monsters"
  add_foreign_key "master_skills", "characteristics"
  add_foreign_key "monster_names", "monsters"
  add_foreign_key "monsters", "monster_classes"
  add_foreign_key "movement_rates", "monsters"
  add_foreign_key "movement_rates", "move_types"
  add_foreign_key "page_references", "books"
  add_foreign_key "page_references", "monsters"
  add_foreign_key "parry_scores", "monsters"
  add_foreign_key "skills", "master_skills"
  add_foreign_key "skills", "monsters"
  add_foreign_key "traits", "master_traits"
  add_foreign_key "traits", "monsters"
end
