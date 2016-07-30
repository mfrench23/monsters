class CreateRpmEffects < ActiveRecord::Migration
  def change
    create_table :rpm_effects do |t|
      t.string :name
      t.integer :cost
      t.text :notes
      t.references :campaign, index: true

      t.timestamps null: false
    end
    add_foreign_key :rpm_effects, :campaigns
    add_index :rpm_effects, [:campaign_id, :name], :name => "idx_rpm_effects_on_name_and_campaign"
  end
end
