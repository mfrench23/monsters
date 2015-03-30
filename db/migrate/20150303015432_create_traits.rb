class CreateTraits < ActiveRecord::Migration
  def change
    create_table :traits do |t|
      t.references :monster, index: true
      t.string :name
      t.text :description
      t.boolean :is_feature
      t.integer :level

      t.timestamps null: false
    end
  end
end
