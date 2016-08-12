class CreateRpmModifiers < ActiveRecord::Migration
  def change
    create_table :rpm_modifiers do |t|
      t.string :name
      t.text :notes
      t.references :campaign, index: true

      t.timestamps null: false
    end
    add_foreign_key :rpm_modifiers, :campaigns
  end
end
