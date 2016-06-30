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

ActiveRecord::Schema.define(version: 20160630002102) do

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
    t.string   "name",         limit: 255, null: false
    t.string   "abbreviation", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "books", ["name"], name: "index_books_on_name", unique: true, using: :btree

  create_table "campaigns", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "campaigns", ["name"], name: "index_campaigns_on_name", unique: true, using: :btree

  create_table "characteristic_lists", force: :cascade do |t|
    t.integer  "characteristic_id",    limit: 4,   null: false
    t.string   "monster_actable_type", limit: 255, null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "characteristic_lists", ["characteristic_id"], name: "index_characteristic_lists_on_characteristic_id", using: :btree
  add_index "characteristic_lists", ["monster_actable_type", "characteristic_id"], name: "index_characteristic_lists_on_monster_type_and_characteristic", unique: true, using: :btree

  create_table "characteristic_monsters", force: :cascade do |t|
    t.integer  "characteristic_id", limit: 4,                         null: false
    t.integer  "monster_id",        limit: 4,                         null: false
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.decimal  "score",                       precision: 6, scale: 2
  end

  add_index "characteristic_monsters", ["characteristic_id", "monster_id"], name: "characteristic_monsters_uniq_join_table_idx", unique: true, using: :btree
  add_index "characteristic_monsters", ["characteristic_id"], name: "index_characteristic_monsters_on_characteristic_id", using: :btree
  add_index "characteristic_monsters", ["monster_id"], name: "index_characteristic_monsters_on_monster_id", using: :btree

  create_table "characteristics", force: :cascade do |t|
    t.string   "name",            limit: 255,                                       null: false
    t.integer  "sequence_number", limit: 4
    t.datetime "created_at",                                                        null: false
    t.datetime "updated_at",                                                        null: false
    t.decimal  "step_size",                   precision: 4, scale: 2, default: 1.0, null: false
    t.decimal  "base_value",                  precision: 6, scale: 2
  end

  add_index "characteristics", ["name"], name: "index_characteristics_on_name", unique: true, using: :btree
  add_index "characteristics", ["sequence_number"], name: "index_characteristics_on_sequence_number", unique: true, using: :btree

  create_table "creatures", force: :cascade do |t|
    t.string   "height",            limit: 255
    t.string   "weight",            limit: 255
    t.integer  "parts_value_cents", limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "damage_resistances", force: :cascade do |t|
    t.integer  "location_id", limit: 4
    t.integer  "dr",          limit: 4,     null: false
    t.text     "notes",       limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "creature_id", limit: 4,     null: false
  end

  add_index "damage_resistances", ["creature_id"], name: "fk_rails_9b36326d78", using: :btree
  add_index "damage_resistances", ["location_id"], name: "index_damage_resistances_on_location_id", using: :btree

  create_table "equipment_categories", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "campaign_id", limit: 4
  end

  add_index "equipment_categories", ["campaign_id"], name: "index_equipment_categories_on_campaign_id", using: :btree
  add_index "equipment_categories", ["name", "campaign_id"], name: "index_equipment_categories_on_name_and_campaign_id", unique: true, using: :btree

  create_table "equipment_modifier_categories", force: :cascade do |t|
    t.string   "name",                                limit: 255
    t.text     "notes",                               limit: 65535
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.integer  "equipment_modifier_supercategory_id", limit: 4
  end

  add_index "equipment_modifier_categories", ["equipment_modifier_supercategory_id"], name: "eq_mod_cat_supercat_idx", using: :btree

  create_table "equipment_modifier_exclusions", force: :cascade do |t|
    t.integer  "equipment_modifier_id", limit: 4
    t.integer  "excluded_id",           limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "equipment_modifier_exclusions", ["equipment_modifier_id", "excluded_id"], name: "equipment_modifier_exclusions_uniq_idx", unique: true, using: :btree
  add_index "equipment_modifier_exclusions", ["equipment_modifier_id"], name: "index_equipment_modifier_exclusions_on_equipment_modifier_id", using: :btree
  add_index "equipment_modifier_exclusions", ["excluded_id"], name: "index_equipment_modifier_exclusions_on_excluded_id", using: :btree

  create_table "equipment_modifier_supercategories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.text     "notes",      limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "equipment_modifiers", force: :cascade do |t|
    t.string   "name",                           limit: 255
    t.string   "base_cost_mod",                  limit: 255
    t.string   "base_weight_mod",                limit: 255
    t.string   "cost_mod",                       limit: 255
    t.string   "weight_mod",                     limit: 255
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.text     "notes",                          limit: 65535
    t.integer  "equipment_modifier_category_id", limit: 4
    t.integer  "random_weight",                  limit: 4,     default: 1
  end

  add_index "equipment_modifiers", ["equipment_modifier_category_id"], name: "index_equipment_modifiers_on_equipment_modifier_category_id", using: :btree

  create_table "equipment_packages", force: :cascade do |t|
    t.integer  "creature_id",      limit: 4
    t.string   "name",             limit: 255
    t.text     "notes",            limit: 65535
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.integer  "total_cost_cents", limit: 4
    t.decimal  "total_weight",                   precision: 10, scale: 4
  end

  add_index "equipment_packages", ["creature_id"], name: "index_equipment_packages_on_creature_id", using: :btree

  create_table "equipment_piece_modifiers", force: :cascade do |t|
    t.integer  "equipment_piece_id",    limit: 4
    t.integer  "equipment_modifier_id", limit: 4
    t.text     "notes",                 limit: 65535
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "equipment_piece_modifiers", ["equipment_modifier_id"], name: "index_equipment_piece_modifiers_on_equipment_modifier_id", using: :btree
  add_index "equipment_piece_modifiers", ["equipment_piece_id"], name: "index_equipment_piece_modifiers_on_equipment_piece_id", using: :btree

  create_table "equipment_pieces", force: :cascade do |t|
    t.integer  "equipment_type_id", limit: 4
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.string   "name",              limit: 255
    t.decimal  "base_weight",                   precision: 10, scale: 4
    t.integer  "base_cost_cents",   limit: 4
    t.decimal  "weight",                        precision: 10, scale: 4
    t.integer  "cost_cents",        limit: 4
    t.integer  "owner_id",          limit: 4
    t.string   "owner_type",        limit: 255
    t.integer  "quantity",          limit: 4,                            null: false
  end

  add_index "equipment_pieces", ["equipment_type_id"], name: "index_equipment_pieces_on_equipment_type_id", using: :btree
  add_index "equipment_pieces", ["owner_type", "owner_id"], name: "index_equipment_pieces_on_owner_type_and_owner_id", using: :btree

  create_table "equipment_type_modifier_categories", force: :cascade do |t|
    t.integer  "equipment_type_id",              limit: 4
    t.integer  "equipment_modifier_category_id", limit: 4
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "equipment_type_modifier_categories", ["equipment_modifier_category_id"], name: "eq_type_mod_cat_mod_cat_idx", using: :btree
  add_index "equipment_type_modifier_categories", ["equipment_type_id"], name: "eq_type_mod_cat_type_idx", using: :btree

  create_table "equipment_types", force: :cascade do |t|
    t.string   "name",                  limit: 255
    t.decimal  "base_weight",                         precision: 10, scale: 4
    t.integer  "base_cost_cents",       limit: 4
    t.integer  "equipment_category_id", limit: 4
    t.text     "notes",                 limit: 65535
    t.datetime "created_at",                                                               null: false
    t.datetime "updated_at",                                                               null: false
    t.string   "unit_of_measurement",   limit: 255
    t.integer  "random_weight",         limit: 4,                              default: 1
    t.integer  "campaign_id",           limit: 4
  end

  add_index "equipment_types", ["campaign_id"], name: "index_equipment_types_on_campaign_id", using: :btree
  add_index "equipment_types", ["equipment_category_id"], name: "index_equipment_types_on_equipment_category_id", using: :btree
  add_index "equipment_types", ["name"], name: "index_equipment_types_on_name", unique: true, using: :btree

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
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "locations", ["name"], name: "index_locations_on_name", unique: true, using: :btree

  create_table "master_skills", force: :cascade do |t|
    t.string   "name",                    limit: 255,   null: false
    t.text     "notes",                   limit: 65535
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "characteristic_id",       limit: 4,     null: false
    t.boolean  "requires_specialization", limit: 1
    t.boolean  "requires_tech_level",     limit: 1
  end

  add_index "master_skills", ["characteristic_id"], name: "index_master_skills_on_characteristic_id", using: :btree
  add_index "master_skills", ["name", "characteristic_id"], name: "index_master_skills_on_name_characteristic_id", unique: true, using: :btree
  add_index "master_skills", ["name"], name: "index_master_skills_on_name", unique: true, using: :btree

  create_table "master_traits", force: :cascade do |t|
    t.string   "name",       limit: 255,   null: false
    t.text     "notes",      limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "master_traits", ["name"], name: "index_master_traits_on_name", using: :btree

  create_table "monster_classes", force: :cascade do |t|
    t.string   "name",           limit: 255, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "monsters_count", limit: 4
  end

  add_index "monster_classes", ["name"], name: "index_monster_classes_on_name", unique: true, using: :btree

  create_table "monster_names", force: :cascade do |t|
    t.integer  "monster_id", limit: 4,     null: false
    t.string   "name",       limit: 255,   null: false
    t.text     "notes",      limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "monster_names", ["monster_id"], name: "index_monster_names_on_monster_id", using: :btree
  add_index "monster_names", ["name"], name: "index_monster_names_on_name", using: :btree

  create_table "monsters", force: :cascade do |t|
    t.text     "description",      limit: 65535
    t.text     "notes",            limit: 65535
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "monster_class_id", limit: 4,                 null: false
    t.string   "name",             limit: 255,               null: false
    t.integer  "actable_id",       limit: 4
    t.string   "actable_type",     limit: 255
    t.string   "ancestry",         limit: 255
    t.integer  "ancestry_depth",   limit: 4,     default: 0
    t.integer  "campaign_id",      limit: 4
  end

  add_index "monsters", ["actable_type", "actable_id"], name: "index_monsters_on_actable_type_and_actable_id", unique: true, using: :btree
  add_index "monsters", ["ancestry"], name: "index_monsters_on_ancestry", using: :btree
  add_index "monsters", ["campaign_id"], name: "index_monsters_on_campaign_id", using: :btree
  add_index "monsters", ["monster_class_id"], name: "index_monsters_on_monster_class_id", using: :btree
  add_index "monsters", ["name"], name: "index_monsters_on_name", unique: true, using: :btree

  create_table "move_types", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "move_types", ["name"], name: "index_move_types_on_name", unique: true, using: :btree

  create_table "movement_rates", force: :cascade do |t|
    t.integer  "monster_id",    limit: 4, null: false
    t.integer  "rate",          limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "move_type_id",  limit: 4
    t.integer  "enhanced_rate", limit: 4
  end

  add_index "movement_rates", ["monster_id"], name: "index_movement_rates_on_monster_id", using: :btree
  add_index "movement_rates", ["move_type_id"], name: "index_movement_rates_on_move_type_id", using: :btree

  create_table "page_references", force: :cascade do |t|
    t.integer  "book_id",            limit: 4
    t.string   "pages",              limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "referenceable_id",   limit: 4
    t.string   "referenceable_type", limit: 255
  end

  add_index "page_references", ["book_id"], name: "index_page_references_on_book_id", using: :btree
  add_index "page_references", ["referenceable_type", "referenceable_id"], name: "index_page_references_on_referenceable_type_and_referenceable_id", using: :btree

  create_table "parry_scores", force: :cascade do |t|
    t.string   "weapon",      limit: 255
    t.integer  "parry",       limit: 4,   null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "creature_id", limit: 4,   null: false
  end

  add_index "parry_scores", ["creature_id"], name: "fk_rails_7faaccd889", using: :btree

  create_table "random_eq_profile_line_items", force: :cascade do |t|
    t.integer  "random_eq_profile_id",                limit: 4
    t.integer  "equipment_modifier_supercategory_id", limit: 4
    t.integer  "quantity",                            limit: 4
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  add_index "random_eq_profile_line_items", ["equipment_modifier_supercategory_id"], name: "rand_eq_prof_line_eq_sprcat_idx", using: :btree
  add_index "random_eq_profile_line_items", ["random_eq_profile_id"], name: "rand_eq_prof_line_idx", using: :btree

  create_table "random_eq_profiles", force: :cascade do |t|
    t.integer  "equipment_type_id",     limit: 4
    t.integer  "equipment_category_id", limit: 4
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.integer  "random_weight",         limit: 4, default: 1
  end

  add_index "random_eq_profiles", ["equipment_category_id"], name: "index_random_eq_profiles_on_equipment_category_id", using: :btree
  add_index "random_eq_profiles", ["equipment_type_id"], name: "index_random_eq_profiles_on_equipment_type_id", using: :btree

  create_table "skills", force: :cascade do |t|
    t.integer  "modifier",        limit: 4,     null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "master_skill_id", limit: 4,     null: false
    t.string   "specialization",  limit: 255
    t.string   "tech_level",      limit: 255
    t.text     "notes",           limit: 65535
    t.integer  "creature_id",     limit: 4,     null: false
  end

  add_index "skills", ["creature_id"], name: "fk_rails_ab183a24b7", using: :btree
  add_index "skills", ["master_skill_id"], name: "index_skills_on_master_skill_id", using: :btree

  create_table "swarms", force: :cascade do |t|
    t.text     "number_description", limit: 65535
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "traits", force: :cascade do |t|
    t.integer  "level",            limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "master_trait_id",  limit: 4,     null: false
    t.text     "notes",            limit: 65535
    t.integer  "trait_owner_id",   limit: 4,     null: false
    t.string   "trait_owner_type", limit: 255,   null: false
    t.string   "ancestry",         limit: 255
    t.integer  "creature_id",      limit: 4
  end

  add_index "traits", ["ancestry"], name: "index_traits_on_ancestry", using: :btree
  add_index "traits", ["creature_id"], name: "index_traits_on_creature_id", using: :btree
  add_index "traits", ["master_trait_id"], name: "index_traits_on_master_trait_id", using: :btree
  add_index "traits", ["trait_owner_id", "trait_owner_type"], name: "index_traits_on_trait_owner_id_and_trait_owner_type", using: :btree

  add_foreign_key "attacks", "monsters"
  add_foreign_key "characteristic_lists", "characteristics"
  add_foreign_key "characteristic_monsters", "characteristics"
  add_foreign_key "characteristic_monsters", "monsters"
  add_foreign_key "damage_resistances", "creatures"
  add_foreign_key "damage_resistances", "locations"
  add_foreign_key "damage_resistances", "locations"
  add_foreign_key "equipment_categories", "campaigns"
  add_foreign_key "equipment_modifier_categories", "equipment_modifier_supercategories"
  add_foreign_key "equipment_modifier_exclusions", "equipment_modifiers"
  add_foreign_key "equipment_modifier_exclusions", "equipment_modifiers", column: "excluded_id"
  add_foreign_key "equipment_modifiers", "equipment_modifier_categories"
  add_foreign_key "equipment_packages", "creatures"
  add_foreign_key "equipment_piece_modifiers", "equipment_modifiers"
  add_foreign_key "equipment_piece_modifiers", "equipment_pieces"
  add_foreign_key "equipment_pieces", "equipment_types"
  add_foreign_key "equipment_type_modifier_categories", "equipment_modifier_categories"
  add_foreign_key "equipment_type_modifier_categories", "equipment_types"
  add_foreign_key "equipment_types", "campaigns"
  add_foreign_key "equipment_types", "equipment_categories"
  add_foreign_key "master_skills", "characteristics"
  add_foreign_key "monster_names", "monsters"
  add_foreign_key "monsters", "campaigns"
  add_foreign_key "monsters", "monster_classes"
  add_foreign_key "movement_rates", "monsters"
  add_foreign_key "movement_rates", "move_types"
  add_foreign_key "page_references", "books"
  add_foreign_key "parry_scores", "creatures"
  add_foreign_key "random_eq_profile_line_items", "equipment_modifier_supercategories"
  add_foreign_key "random_eq_profile_line_items", "random_eq_profiles"
  add_foreign_key "random_eq_profiles", "equipment_categories"
  add_foreign_key "random_eq_profiles", "equipment_types"
  add_foreign_key "skills", "creatures"
  add_foreign_key "skills", "master_skills"
  add_foreign_key "traits", "creatures"
  add_foreign_key "traits", "master_traits"
end
