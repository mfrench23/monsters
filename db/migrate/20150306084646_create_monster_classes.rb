class CreateMonsterClasses < ActiveRecord::Migration
  def change
    create_table :monster_classes do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
