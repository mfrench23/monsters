class CreateMonsters < ActiveRecord::Migration
  def change
    create_table :monsters do |t|
      t.integer :strength
      t.integer :dexterity
      t.integer :intelligence
      t.integer :health
      t.integer :hitPoints
      t.integer :will
      t.integer :perception
      t.integer :fatigue
      t.integer :sizeModifier
      t.string :height
      t.string :weight
      t.text :gear
      t.text :description
      t.text :notes
      t.integer :dodge
      t.integer :block

      t.timestamps null: false
    end
    add_column :monsters, :speed, :decimal, precision:4, scale:2
    
    add_foreign_key :page_references, :monsters
    add_foreign_key :page_references, :books
    add_foreign_key :skills, :monsters
    add_foreign_key :traits, :monsters
    add_foreign_key :attacks, :monsters
    add_foreign_key :damage_resistances, :monsters
    add_foreign_key :damage_resistances, :locations
    add_foreign_key :movement_rates, :monsters
    add_foreign_key :movement_rates, :terrain_types
    add_foreign_key :monster_names, :monsters
    
  end
end
