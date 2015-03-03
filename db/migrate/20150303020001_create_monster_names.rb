class CreateMonsterNames < ActiveRecord::Migration
  def change
    create_table :monster_names do |t|
      t.references :monster, index: true
      t.boolean :primary
      t.string :name
      t.text :notes

      t.timestamps null: false
    end
  end
end
