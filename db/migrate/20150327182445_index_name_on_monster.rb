class IndexNameOnMonster < ActiveRecord::Migration
  def change
    change_table :monsters do |t|
      t.index :name
    end
  end
end
