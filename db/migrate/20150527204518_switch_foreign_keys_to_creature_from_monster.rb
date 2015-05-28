class SwitchForeignKeysToCreatureFromMonster < ActiveRecord::Migration
  def up
    table_list.each { |t| do_up t }
  end

  def down
    table_list.each { |t| do_down t }
  end

  private

  def table_list
    [ :damage_resistances, :parry_scores, :skills, :traits ]
  end

  def do_up(t)
    add_column t, :creature_id, :integer
    add_foreign_key t, :creatures
    execute "update #{t} d set creature_id = (select id from creatures c where c.monster_id = d.monster_id), updated_at = now()"
    remove_foreign_key t, :monsters
    remove_column t, :monster_id
  end

  def do_down(t)
    add_column t, :monster_id, :integer
    add_foreign_key t, :monsters
    execute "update #{t} d set monster_id = (select id from monsters c where c.actable_id = d.creature_id and c.actable_type = 'Creature'), updated_at = now()"
    remove_foreign_key t, :creatures
    remove_column t, :creature_id
  end
end
