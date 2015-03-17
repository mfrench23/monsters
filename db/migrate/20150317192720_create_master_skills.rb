class CreateMasterSkills < ActiveRecord::Migration
  def change
    create_table :master_skills do |t|
      t.string :name
      t.integer :baseStat
      t.text :notes

      t.timestamps null: false
    end
    add_index :master_skills, :name
  end
end
