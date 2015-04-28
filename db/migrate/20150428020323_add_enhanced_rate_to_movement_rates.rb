class AddEnhancedRateToMovementRates < ActiveRecord::Migration
  def change
    add_column :movement_rates, :enhanced_rate, :integer
  end
end
