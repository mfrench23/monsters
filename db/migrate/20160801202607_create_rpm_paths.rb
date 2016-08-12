class CreateRpmPaths < ActiveRecord::Migration
  def change
    create_table :rpm_paths do |t|
      t.string :name
      t.text :notes
      t.references :campaign, index: true

      t.timestamps null: false
    end
    add_foreign_key :rpm_paths, :campaigns
  end
end
