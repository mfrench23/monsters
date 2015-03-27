class IndexNameOnTerrainTypes < ActiveRecord::Migration
  def change
    change_table :terrain_types do |t|
      t.index :name
    end
  end
end
