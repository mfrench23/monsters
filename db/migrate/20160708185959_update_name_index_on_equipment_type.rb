class UpdateNameIndexOnEquipmentType < ActiveRecord::Migration
  def change
    remove_index :equipment_types, :name => 'index_equipment_types_on_name'
    add_index :equipment_types, [:campaign_id, :name], :name => "idx_equipment_types_on_name_and_campaign"
  end
end
