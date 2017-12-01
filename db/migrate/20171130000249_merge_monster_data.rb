class MergeMonsterData < ActiveRecord::Migration
  def up
    execute "update monsters m inner join creatures c on m.actable_id = c.id and m.actable_type = 'Creature' set m.height = c.height, m.weight = c.weight, m.parts_value_cents = c.parts_value_cents, type = 'Creature';"
    execute "update monsters m inner join swarms c on m.actable_id = c.id and m.actable_type = 'Swarm' set m.number_description = c.number_description, type = 'Swarm';"

    transplant_fk(:damage_resistances)
    transplant_fk(:equipment_packages, true)
    transplant_fk(:parry_scores)
    transplant_fk(:skills)

    execute "update traits d inner join monsters m on m.actable_type = 'Creature' and m.actable_id = d.trait_owner_id set d.trait_owner_id = m.id, trait_owner_type = 'Monster' where d.trait_owner_type = 'Creature';"
    transplant_fk(:traits, true)

    drop_table :swarms
    drop_table :creatures

    remove_index :monsters, :name => 'index_monsters_on_actable_type_and_actable_id'
    remove_column :monsters, :actable_id
    remove_column :monsters, :actable_type
  end

  def transplant_fk(tbl, nullable=false)
    add_column tbl, :monster_id, :integer
    execute "update #{tbl.to_s} d inner join monsters m on m.actable_type = 'Creature' and m.actable_id = d.creature_id set d.monster_id = m.id;"
    execute "delete from #{tbl.to_s} where creature_id is null;"
    unless nullable
      change_column tbl, :monster_id, :integer, null: false
    end
    remove_foreign_key tbl, :creatures
    remove_column tbl, :creature_id
    add_foreign_key tbl.to_s, "monsters"
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
