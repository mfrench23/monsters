class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.references :monster, index: true
      t.string :name
      t.string :trait
      t.integer :modifier

      t.timestamps null: false
    end
  end
end
