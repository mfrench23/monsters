class CreateTerrainTypes < ActiveRecord::Migration
  def change
    create_table :terrain_types do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
