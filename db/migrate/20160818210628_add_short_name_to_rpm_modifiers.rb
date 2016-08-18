class AddShortNameToRpmModifiers < ActiveRecord::Migration
  def change
    add_column :rpm_modifiers, :short_name, :string
  end
end
