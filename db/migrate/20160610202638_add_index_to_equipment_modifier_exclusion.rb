class AddIndexToEquipmentModifierExclusion < ActiveRecord::Migration
  def change
    ActiveRecord::Base.connection.execute('delete from equipment_modifier_exclusions
      where id in
      (
      select max_id
      from
              (
              select equipment_modifier_id, excluded_id, count(*), max(id) as max_id
              from equipment_modifier_exclusions
              group by equipment_modifier_id, excluded_id
              having count(*) > 1
              ) q1
      )')
    add_index :equipment_modifier_exclusions, [:equipment_modifier_id, :excluded_id], :unique => true, :name => 'equipment_modifier_exclusions_uniq_idx'
  end
end
