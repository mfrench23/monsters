class CreateRpmRitualVariants < ActiveRecord::Migration[5.0]
  def change
    create_table :rpm_ritual_variants do |t|
      t.references :rpm_ritual, foreign_key: true
      t.string :name
      t.text :description
      t.integer :typical_cost

      t.timestamps
    end
  end
end
