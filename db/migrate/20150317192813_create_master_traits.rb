class CreateMasterTraits < ActiveRecord::Migration
  def change
    create_table :master_traits do |t|
      t.string :name
      t.text :notes
      t.boolean :is_feature

      t.timestamps null: false
    end
    add_index :master_traits, :name
  end
end
