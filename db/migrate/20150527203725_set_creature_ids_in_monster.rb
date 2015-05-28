class SetCreatureIdsInMonster < ActiveRecord::Migration
  def up
    execute "update monsters m set actable_type='Creature', actable_id = (select id from creatures c where c.monster_id = m.id), updated_at = now()"
  end

  def down
    execute "update monsters m set actable_type=null, actable_id = null, updated_at = now()"
  end
end
