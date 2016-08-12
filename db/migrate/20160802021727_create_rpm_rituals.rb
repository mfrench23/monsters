class CreateRpmRituals < ActiveRecord::Migration
  def change
    create_table :rpm_rituals do |t|
      t.string :name
      t.text :description
      t.integer :typical_cost
      t.references :campaign, index: true

      t.timestamps null: false
    end
    add_foreign_key :rpm_rituals, :campaigns
  end
end
