class UpdateNameIndexOnEquipmentCategory < ActiveRecord::Migration
  def change
    remove_index :equipment_categories, :name => 'index_equipment_categories_on_name_and_campaign_id'
    add_index :equipment_categories, [:campaign_id, :name], :name => "index_equipment_categories_on_name_and_campaign_id"
  end
end
