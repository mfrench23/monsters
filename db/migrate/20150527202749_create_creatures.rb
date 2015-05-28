class CreateCreatures < ActiveRecord::Migration
  def change
    create_table :creatures do |t|
      t.string :height
      t.string :weight
      t.text :gear
      t.integer :parts_value_cents
      t.references :monster, index: true

      t.timestamps null: false
    end
    add_foreign_key :creatures, :monsters
    execute "insert into creatures (height, weight, gear, parts_value_cents, monster_id, created_at, updated_at) select height, weight, gear, parts_value_cents, id as monster_id, now(), now() from monsters"
  end
end
