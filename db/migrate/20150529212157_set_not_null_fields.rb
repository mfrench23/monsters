class SetNotNullFields < ActiveRecord::Migration
  def change
    change_column_null :books, :name, false
    change_column_null :characteristic_lists, :characteristic_id, false
    change_column_null :characteristic_lists, :monster_actable_type, false
    change_column_null :characteristic_monsters, :characteristic_id, false
    change_column_null :characteristic_monsters, :monster_id, false
    change_column_null :characteristics, :name, false
    change_column_null :characteristics, :step_size, false
    change_column_null :damage_resistances, :dr, false
    change_column_null :damage_resistances, :creature_id, false
    change_column_null :locations, :name, false
    change_column_null :master_skills, :name, false
    change_column_null :master_skills, :characteristic_id, false
    change_column_null :master_traits, :name, false
    change_column_null :monster_classes, :name, false
    change_column_null :monster_names, :name, false
    change_column_null :monster_names, :monster_id, false
    change_column_null :monsters, :monster_class_id, false
    change_column_null :monsters, :name, false
    change_column_null :move_types, :name, false
    change_column_null :movement_rates, :monster_id, false
    change_column_null :page_references, :monster_id, false
    change_column_null :parry_scores, :parry, false
    change_column_null :parry_scores, :creature_id, false
    remove_column :parry_scores, :monster_id_id, :integer, null:true
    change_column_null :skills, :modifier, false
    change_column_null :skills, :master_skill_id, false
    change_column_null :skills, :creature_id, false
    change_column_null :traits, :creature_id, false
    change_column_null :traits, :master_trait_id, false
  end
end
