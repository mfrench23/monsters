class AddStepSizeToCharacteristics < ActiveRecord::Migration
  def change
    add_column :characteristics, :step_size, :decimal, precision:4, scale:2, default: 1.0
  end
end
