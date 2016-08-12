class CreateRpmPotency < ActiveRecord::Migration
  def change
    create_table :rpm_potencies do |t|
      t.string :rpm_potency
      t.string :name
      t.text :notes
      t.references :campaign, index: true

      t.timestamps null: false
    end
    add_foreign_key :rpm_potencies, :campaigns
  end
end
