class IndexBookNameAndAbbreviation < ActiveRecord::Migration
  def change
    change_table :books do |t|
      t.index :name
      t.index :abbreviation
    end
  end
end
