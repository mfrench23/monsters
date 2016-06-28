class AddCampaignIdToEquipmentType < ActiveRecord::Migration
  def change
    add_reference :equipment_types, :campaign, index: true
    add_foreign_key :equipment_types, :campaigns
    ActiveRecord::Base.connection.execute("update equipment_types e
                                          set campaign_id =
                                            (select campaign_id 
                                            from campaign_contents cc 
                                            where cc.content_id = e.id
                                                    and cc.content_type = 'EquipmentType')");
  end
end
