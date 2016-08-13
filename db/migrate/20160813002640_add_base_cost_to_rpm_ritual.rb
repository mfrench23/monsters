class AddBaseCostToRpmRitual < ActiveRecord::Migration
  def change
    add_column :rpm_rituals, :inherent_cost, :integer
  end
end
