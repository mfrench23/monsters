class CreateEquipmentPackages < ActiveRecord::Migration
  def change
    create_table :equipment_packages do |t|
      t.references :creature, index: true
      t.string :name
      t.text :notes

      t.timestamps null: false
    end
    add_foreign_key :equipment_packages, :creatures
  end
end
