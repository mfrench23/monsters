class AddCampaignIdToEquipmentCategory < ActiveRecord::Migration
  def change
    add_reference :equipment_categories, :campaign, index: true
    add_foreign_key :equipment_categories, :campaigns
    ActiveRecord::Base.connection.execute("update equipment_categories e
                                          set campaign_id =
                                            (select distinct campaign_id 
                                            from equipment_types t 
                                            where t.equipment_category_id = e.id)");
  end
end
