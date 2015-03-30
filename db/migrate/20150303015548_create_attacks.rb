class CreateAttacks < ActiveRecord::Migration
  def change
    create_table :attacks do |t|
      t.references :monster, index: true
      t.string :name
      t.string :skill
      t.string :description

      t.timestamps null: false
    end
  end
end
