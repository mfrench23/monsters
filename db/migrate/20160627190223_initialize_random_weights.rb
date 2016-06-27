class InitializeRandomWeights < ActiveRecord::Migration
  def change
    ActiveRecord::Base.connection.execute('update equipment_modifiers set random_weight = 1');
    ActiveRecord::Base.connection.execute('update equipment_types set random_weight = 1');
    ActiveRecord::Base.connection.execute('update random_eq_profiles set random_weight = 1');
  end
end
