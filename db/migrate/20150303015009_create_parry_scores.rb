class CreateParryScores < ActiveRecord::Migration
  def change
    create_table :parry_scores do |t|
      t.string :weapon
      t.integer :parry

      t.timestamps null: false
    end
  end
end
