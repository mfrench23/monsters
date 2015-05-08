class AddBaseValueToCharacteristics < ActiveRecord::Migration
  def change
    add_column :characteristics, :base_value, :decimal, :precision => 6, :scale => 2
  end
end
