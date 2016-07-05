class AddQuantityToRandomEqProfile < ActiveRecord::Migration
  def change
    add_column :random_eq_profiles, :quantity, :string
  end
end
