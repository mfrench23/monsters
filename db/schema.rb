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

ActiveRecord::Schema.define(version: 20180908165516) do

  create_table "attacks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "monster_id"
    t.string   "name"
    t.string   "skill"
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["monster_id", "name"], name: "index_attacks_on_monster_id_and_name", unique: true, using: :btree
    t.index ["monster_id"], name: "index_attacks_on_monster_id", using: :btree
  end

  create_table "books", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name",         null: false
    t.string   "abbreviation"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["name"], name: "index_books_on_name", unique: true, using: :btree
  end

  create_table "campaigns", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_campaigns_on_name", unique: true, using: :btree
  end

  create_table "characteristic_lists", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "characteristic_id",    null: false
    t.string   "monster_actable_type", null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["characteristic_id"], name: "index_characteristic_lists_on_characteristic_id", using: :btree
    t.index ["monster_actable_type", "characteristic_id"], name: "index_characteristic_lists_on_monster_type_and_characteristic", unique: true, using: :btree
  end

  create_table "characteristic_monsters", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "characteristic_id",                         null: false
    t.integer  "monster_id",                                null: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.decimal  "score",             precision: 6, scale: 2
    t.index ["characteristic_id", "monster_id"], name: "characteristic_monsters_uniq_join_table_idx", unique: true, using: :btree
    t.index ["characteristic_id"], name: "index_characteristic_monsters_on_characteristic_id", using: :btree
    t.index ["monster_id"], name: "index_characteristic_monsters_on_monster_id", using: :btree
  end

  create_table "characteristics", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name",                                                    null: false
    t.integer  "sequence_number"
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.decimal  "step_size",       precision: 4, scale: 2, default: "1.0", null: false
    t.decimal  "base_value",      precision: 6, scale: 2
    t.index ["name"], name: "index_characteristics_on_name", unique: true, using: :btree
    t.index ["sequence_number"], name: "index_characteristics_on_sequence_number", unique: true, using: :btree
  end

  create_table "damage_resistances", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "location_id"
    t.integer  "dr",                        null: false
    t.text     "notes",       limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "monster_id",                null: false
    t.index ["location_id"], name: "index_damage_resistances_on_location_id", using: :btree
    t.index ["monster_id"], name: "fk_rails_2806873aea", using: :btree
  end

  create_table "equipment_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "campaign_id"
    t.index ["campaign_id", "name"], name: "index_equipment_categories_on_name_and_campaign_id", using: :btree
    t.index ["campaign_id"], name: "index_equipment_categories_on_campaign_id", using: :btree
  end

  create_table "equipment_modifier_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name"
    t.text     "notes",                               limit: 65535
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.integer  "equipment_modifier_supercategory_id"
    t.index ["equipment_modifier_supercategory_id"], name: "eq_mod_cat_supercat_idx", using: :btree
  end

  create_table "equipment_modifier_exclusions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "equipment_modifier_id"
    t.integer  "excluded_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["equipment_modifier_id", "excluded_id"], name: "equipment_modifier_exclusions_uniq_idx", unique: true, using: :btree
    t.index ["equipment_modifier_id"], name: "index_equipment_modifier_exclusions_on_equipment_modifier_id", using: :btree
    t.index ["excluded_id"], name: "index_equipment_modifier_exclusions_on_excluded_id", using: :btree
  end

  create_table "equipment_modifier_supercategories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name"
    t.text     "notes",      limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "equipment_modifiers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name"
    t.string   "base_cost_mod"
    t.string   "base_weight_mod"
    t.string   "cost_mod"
    t.string   "weight_mod"
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.text     "notes",                          limit: 65535
    t.integer  "equipment_modifier_category_id"
    t.integer  "random_weight",                                default: 1
    t.index ["equipment_modifier_category_id"], name: "index_equipment_modifiers_on_equipment_modifier_category_id", using: :btree
  end

  create_table "equipment_packages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name"
    t.text     "notes",            limit: 65535
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.integer  "total_cost_cents"
    t.decimal  "total_weight",                   precision: 10, scale: 4
    t.integer  "monster_id"
    t.index ["monster_id"], name: "fk_rails_b280677852", using: :btree
  end

  create_table "equipment_piece_modifiers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "equipment_piece_id"
    t.integer  "equipment_modifier_id"
    t.text     "notes",                 limit: 65535
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["equipment_modifier_id"], name: "index_equipment_piece_modifiers_on_equipment_modifier_id", using: :btree
    t.index ["equipment_piece_id"], name: "index_equipment_piece_modifiers_on_equipment_piece_id", using: :btree
  end

  create_table "equipment_pieces", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "equipment_type_id"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "name"
    t.decimal  "base_weight",       precision: 10, scale: 4
    t.integer  "base_cost_cents"
    t.decimal  "weight",            precision: 10, scale: 4
    t.integer  "cost_cents"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.integer  "quantity",                                   null: false
    t.index ["equipment_type_id"], name: "index_equipment_pieces_on_equipment_type_id", using: :btree
    t.index ["owner_type", "owner_id"], name: "index_equipment_pieces_on_owner_type_and_owner_id", using: :btree
  end

  create_table "equipment_type_modifier_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "equipment_type_id"
    t.integer  "equipment_modifier_category_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["equipment_modifier_category_id"], name: "eq_type_mod_cat_mod_cat_idx", using: :btree
    t.index ["equipment_type_id"], name: "eq_type_mod_cat_type_idx", using: :btree
  end

  create_table "equipment_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name"
    t.decimal  "base_weight",                         precision: 10, scale: 4
    t.integer  "base_cost_cents"
    t.integer  "equipment_category_id"
    t.text     "notes",                 limit: 65535
    t.datetime "created_at",                                                               null: false
    t.datetime "updated_at",                                                               null: false
    t.string   "unit_of_measurement"
    t.integer  "random_weight",                                                default: 1
    t.integer  "campaign_id"
    t.index ["campaign_id", "name"], name: "idx_equipment_types_on_name_and_campaign", using: :btree
    t.index ["campaign_id"], name: "index_equipment_types_on_campaign_id", using: :btree
    t.index ["equipment_category_id"], name: "index_equipment_types_on_equipment_category_id", using: :btree
  end

  create_table "illustrations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "illustratable_id"
    t.string   "illustratable_type"
    t.text     "notes",              limit: 65535
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.index ["illustratable_type", "illustratable_id"], name: "index_illustrations_on_illustratable_type_and_illustratable_id", using: :btree
  end

  create_table "locations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_locations_on_name", unique: true, using: :btree
  end

  create_table "master_skills", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name",                                  null: false
    t.text     "notes",                   limit: 65535
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "characteristic_id",                     null: false
    t.boolean  "requires_specialization"
    t.boolean  "requires_tech_level"
    t.index ["characteristic_id"], name: "index_master_skills_on_characteristic_id", using: :btree
    t.index ["name", "characteristic_id"], name: "index_master_skills_on_name_characteristic_id", unique: true, using: :btree
    t.index ["name"], name: "index_master_skills_on_name", unique: true, using: :btree
  end

  create_table "master_traits", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name",                     null: false
    t.text     "notes",      limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["name"], name: "index_master_traits_on_name", using: :btree
  end

  create_table "monster_classes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name",           null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "monsters_count"
    t.index ["name"], name: "index_monster_classes_on_name", unique: true, using: :btree
  end

  create_table "monster_names", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "monster_id",               null: false
    t.string   "name",                     null: false
    t.text     "notes",      limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["monster_id"], name: "index_monster_names_on_monster_id", using: :btree
    t.index ["name"], name: "index_monster_names_on_name", using: :btree
  end

  create_table "monsters", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.text     "description",        limit: 65535
    t.text     "notes",              limit: 65535
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.integer  "monster_class_id",                             null: false
    t.string   "name",                                         null: false
    t.string   "ancestry"
    t.integer  "ancestry_depth",                   default: 0
    t.integer  "campaign_id"
    t.string   "type"
    t.text     "number_description", limit: 65535
    t.string   "height"
    t.string   "weight"
    t.integer  "parts_value_cents"
    t.index ["ancestry"], name: "index_monsters_on_ancestry", using: :btree
    t.index ["campaign_id"], name: "index_monsters_on_campaign_id", using: :btree
    t.index ["monster_class_id"], name: "index_monsters_on_monster_class_id", using: :btree
    t.index ["name"], name: "index_monsters_on_name", unique: true, using: :btree
  end

  create_table "move_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_move_types_on_name", unique: true, using: :btree
  end

  create_table "movement_rates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "monster_id",    null: false
    t.integer  "rate"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "move_type_id"
    t.integer  "enhanced_rate"
    t.index ["monster_id"], name: "index_movement_rates_on_monster_id", using: :btree
    t.index ["move_type_id"], name: "index_movement_rates_on_move_type_id", using: :btree
  end

  create_table "page_references", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "book_id"
    t.string   "pages"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "referenceable_id"
    t.string   "referenceable_type"
    t.index ["book_id"], name: "index_page_references_on_book_id", using: :btree
    t.index ["referenceable_type", "referenceable_id"], name: "index_page_references_on_referenceable_type_and_referenceable_id", using: :btree
  end

  create_table "parry_scores", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "weapon"
    t.integer  "parry",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "monster_id", null: false
    t.index ["monster_id"], name: "fk_rails_27f3207407", using: :btree
  end

  create_table "random_eq_profile_line_items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "random_eq_profile_id"
    t.integer  "equipment_modifier_supercategory_id"
    t.integer  "quantity"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "equipment_modifier_category_id"
    t.index ["equipment_modifier_category_id"], name: "rnd_eq_prof_line_itm_cat_idx", using: :btree
    t.index ["equipment_modifier_supercategory_id"], name: "rand_eq_prof_line_eq_sprcat_idx", using: :btree
    t.index ["random_eq_profile_id"], name: "rand_eq_prof_line_idx", using: :btree
  end

  create_table "random_eq_profiles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "equipment_type_id"
    t.integer  "equipment_category_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "random_weight",         default: 1
    t.string   "quantity"
    t.index ["equipment_category_id"], name: "index_random_eq_profiles_on_equipment_category_id", using: :btree
    t.index ["equipment_type_id"], name: "index_random_eq_profiles_on_equipment_type_id", using: :btree
  end

  create_table "rpm_effects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name"
    t.integer  "cost"
    t.text     "notes",       limit: 65535
    t.integer  "campaign_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["campaign_id", "name"], name: "idx_rpm_effects_on_name_and_campaign", using: :btree
    t.index ["campaign_id"], name: "index_rpm_effects_on_campaign_id", using: :btree
  end

  create_table "rpm_modifier_levels", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "rpm_modifier_id"
    t.string   "description"
    t.integer  "cost"
    t.boolean  "include_notes_in_summary"
    t.boolean  "accepts_enhancements"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["rpm_modifier_id"], name: "index_rpm_modifier_levels_on_rpm_modifier_id", using: :btree
  end

  create_table "rpm_modifier_subtypes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "rpm_modifier_id"
    t.string   "name"
    t.decimal  "multiplier",      precision: 5, scale: 2
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.index ["rpm_modifier_id"], name: "index_rpm_modifier_subtypes_on_rpm_modifier_id", using: :btree
  end

  create_table "rpm_modifiers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name"
    t.text     "notes",                      limit: 65535
    t.integer  "campaign_id"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "short_name"
    t.boolean  "exclude_level_from_summary"
    t.index ["campaign_id"], name: "index_rpm_modifiers_on_campaign_id", using: :btree
  end

  create_table "rpm_paths", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name"
    t.text     "notes",       limit: 65535
    t.integer  "campaign_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["campaign_id"], name: "index_rpm_paths_on_campaign_id", using: :btree
  end

  create_table "rpm_potencies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "rpm_potency"
    t.string   "name"
    t.text     "notes",       limit: 65535
    t.integer  "campaign_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "cost_factor"
    t.index ["campaign_id"], name: "index_rpm_potencies_on_campaign_id", using: :btree
  end

  create_table "rpm_ritual_modifiers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "rpm_ritual_id"
    t.integer  "rpm_modifier_level_id"
    t.text     "notes",                   limit: 65535
    t.integer  "enhancement_percentage"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.boolean  "inherent"
    t.text     "enhancement_notes",       limit: 65535
    t.integer  "rpm_modifier_subtype_id"
    t.boolean  "enhancement_only"
    t.index ["rpm_modifier_level_id"], name: "index_rpm_ritual_modifiers_on_rpm_modifier_level_id", using: :btree
    t.index ["rpm_modifier_subtype_id"], name: "index_rpm_ritual_modifiers_on_rpm_modifier_subtype_id", using: :btree
    t.index ["rpm_ritual_id"], name: "index_rpm_ritual_modifiers_on_rpm_ritual_id", using: :btree
  end

  create_table "rpm_ritual_variant_modifiers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "rpm_ritual_variant_id"
    t.integer  "rpm_modifier_level_id"
    t.text     "notes",                   limit: 65535
    t.integer  "enhancement_percentage"
    t.text     "enhancement_notes",       limit: 65535
    t.integer  "rpm_modifier_subtype_id"
    t.boolean  "enhancement_only"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.index ["rpm_modifier_level_id"], name: "index_rpm_ritual_variant_modifiers_on_rpm_modifier_level_id", using: :btree
    t.index ["rpm_modifier_subtype_id"], name: "index_rpm_ritual_variant_modifiers_on_rpm_modifier_subtype_id", using: :btree
    t.index ["rpm_ritual_variant_id"], name: "index_rpm_ritual_variant_modifiers_on_rpm_ritual_variant_id", using: :btree
  end

  create_table "rpm_ritual_variants", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "rpm_ritual_id"
    t.string   "name"
    t.text     "description",   limit: 65535
    t.integer  "typical_cost"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["rpm_ritual_id"], name: "index_rpm_ritual_variants_on_rpm_ritual_id", using: :btree
  end

  create_table "rpm_rituals", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name"
    t.text     "description",   limit: 65535
    t.integer  "typical_cost"
    t.integer  "campaign_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "inherent_cost"
    t.index ["campaign_id"], name: "index_rpm_rituals_on_campaign_id", using: :btree
  end

  create_table "rpm_spell_effects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "rpm_ritual_id"
    t.integer  "rpm_potency_id"
    t.integer  "rpm_effect_id"
    t.integer  "rpm_path_id"
    t.text     "notes",          limit: 65535
    t.boolean  "inherent"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["rpm_effect_id"], name: "index_rpm_spell_effects_on_rpm_effect_id", using: :btree
    t.index ["rpm_path_id"], name: "index_rpm_spell_effects_on_rpm_path_id", using: :btree
    t.index ["rpm_potency_id"], name: "index_rpm_spell_effects_on_rpm_potency_id", using: :btree
    t.index ["rpm_ritual_id", "inherent"], name: "index_rpm_spell_effects_on_rpm_ritual_id_and_inherent", using: :btree
  end

  create_table "skills", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "modifier",                      null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "master_skill_id",               null: false
    t.string   "specialization"
    t.string   "tech_level"
    t.text     "notes",           limit: 65535
    t.integer  "monster_id",                    null: false
    t.index ["master_skill_id"], name: "index_skills_on_master_skill_id", using: :btree
    t.index ["monster_id"], name: "fk_rails_cdabc69603", using: :btree
  end

  create_table "traits", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "level"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "master_trait_id",                null: false
    t.text     "notes",            limit: 65535
    t.integer  "trait_owner_id",                 null: false
    t.string   "trait_owner_type",               null: false
    t.string   "ancestry"
    t.integer  "monster_id"
    t.index ["ancestry"], name: "index_traits_on_ancestry", using: :btree
    t.index ["master_trait_id"], name: "index_traits_on_master_trait_id", using: :btree
    t.index ["monster_id"], name: "fk_rails_749a4d582c", using: :btree
    t.index ["trait_owner_id", "trait_owner_type"], name: "index_traits_on_trait_owner_id_and_trait_owner_type", using: :btree
  end

  add_foreign_key "attacks", "monsters"
  add_foreign_key "characteristic_lists", "characteristics"
  add_foreign_key "characteristic_monsters", "characteristics"
  add_foreign_key "characteristic_monsters", "monsters"
  add_foreign_key "damage_resistances", "locations"
  add_foreign_key "damage_resistances", "monsters"
  add_foreign_key "equipment_categories", "campaigns"
  add_foreign_key "equipment_modifier_categories", "equipment_modifier_supercategories"
  add_foreign_key "equipment_modifier_exclusions", "equipment_modifiers"
  add_foreign_key "equipment_modifier_exclusions", "equipment_modifiers", column: "excluded_id"
  add_foreign_key "equipment_modifiers", "equipment_modifier_categories"
  add_foreign_key "equipment_packages", "monsters"
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
  add_foreign_key "parry_scores", "monsters"
  add_foreign_key "random_eq_profile_line_items", "equipment_modifier_categories"
  add_foreign_key "random_eq_profile_line_items", "equipment_modifier_supercategories"
  add_foreign_key "random_eq_profile_line_items", "random_eq_profiles"
  add_foreign_key "random_eq_profiles", "equipment_categories"
  add_foreign_key "random_eq_profiles", "equipment_types"
  add_foreign_key "rpm_effects", "campaigns"
  add_foreign_key "rpm_modifier_levels", "rpm_modifiers"
  add_foreign_key "rpm_modifier_subtypes", "rpm_modifiers"
  add_foreign_key "rpm_modifiers", "campaigns"
  add_foreign_key "rpm_paths", "campaigns"
  add_foreign_key "rpm_potencies", "campaigns"
  add_foreign_key "rpm_ritual_modifiers", "rpm_modifier_levels"
  add_foreign_key "rpm_ritual_modifiers", "rpm_modifier_subtypes"
  add_foreign_key "rpm_ritual_modifiers", "rpm_rituals"
  add_foreign_key "rpm_ritual_variant_modifiers", "rpm_modifier_levels"
  add_foreign_key "rpm_ritual_variant_modifiers", "rpm_modifier_subtypes"
  add_foreign_key "rpm_ritual_variant_modifiers", "rpm_ritual_variants"
  add_foreign_key "rpm_ritual_variants", "rpm_rituals"
  add_foreign_key "rpm_rituals", "campaigns"
  add_foreign_key "rpm_spell_effects", "rpm_effects"
  add_foreign_key "rpm_spell_effects", "rpm_paths"
  add_foreign_key "rpm_spell_effects", "rpm_potencies"
  add_foreign_key "rpm_spell_effects", "rpm_rituals"
  add_foreign_key "skills", "master_skills"
  add_foreign_key "skills", "monsters"
  add_foreign_key "traits", "master_traits"
  add_foreign_key "traits", "monsters"
end
