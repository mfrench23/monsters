class EquipmentCategoryUniqueAcrossCampaign < ActiveRecord::Migration
  def change
    remove_index :equipment_categories, :name
    add_index :equipment_categories, [:name, :campaign_id], :unique => true
  end
end
