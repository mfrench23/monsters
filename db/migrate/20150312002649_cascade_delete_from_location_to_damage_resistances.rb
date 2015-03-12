class CascadeDeleteFromLocationToDamageResistances < ActiveRecord::Migration
  def change
    add_foreign_key :damage_resistances, :locations, :dependent => :destroy
  end
end
