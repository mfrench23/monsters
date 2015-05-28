class CreateCharacteristicLists < ActiveRecord::Migration
  def up
    create_table :characteristic_lists do |t|
      t.references :characteristic, index: true
      t.string :monster_actable_type

      t.timestamps null: false
    end
    add_foreign_key :characteristic_lists, :characteristics
    execute "insert into characteristic_lists (characteristic_id, monster_actable_type, created_at, updated_at) select id, 'Creature', now(), now() from characteristics"
    execute "insert into characteristic_lists (characteristic_id, monster_actable_type, created_at, updated_at) select id, 'Swarm', now(), now() from characteristics where name in ('HP', 'HT')"
  end

  def down
    drop_table :characteristic_lists
  end
end
