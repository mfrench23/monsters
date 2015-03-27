class IndexNameOnMonsterClasses < ActiveRecord::Migration
  def change
    change_table :monster_classes do |t|
      t.index :name
    end
  end
end
