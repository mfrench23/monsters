class SetDefaultForRandomWeight < ActiveRecord::Migration
  def change
    change_column_default :equipment_modifiers, :random_weight, 1
    change_column_default :equipment_types, :random_weight, 1
    change_column_default :random_eq_profiles, :random_weight, 1
  end
end
