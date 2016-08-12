class AddCostFactorToRpmPotency < ActiveRecord::Migration
  def change
    add_column :rpm_potencies, :cost_factor, :integer
  end
end
