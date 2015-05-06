class CreateCharacteristicMonsters < ActiveRecord::Migration
  def change
    create_table :characteristic_monsters do |t|
      t.references :characteristic, index: true
      t.references :monster, index: true

      t.timestamps null: false
    end
    add_foreign_key :characteristic_monsters, :characteristics
    add_foreign_key :characteristic_monsters, :monsters
  end
end
