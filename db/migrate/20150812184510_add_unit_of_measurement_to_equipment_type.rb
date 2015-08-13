class AddUnitOfMeasurementToEquipmentType < ActiveRecord::Migration
  def change
    add_column :equipment_types, :unit_of_measurement, :string
  end
end
