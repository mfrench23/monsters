class AddRandomWeightToRandomEqProfile < ActiveRecord::Migration
  def change
    add_column :random_eq_profiles, :random_weight, :integer
  end
end
