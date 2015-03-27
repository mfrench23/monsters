class IndexNameOnMonsterNames < ActiveRecord::Migration
  def change
    change_table :monster_names do |t|
      t.index :name
    end
  end
end
