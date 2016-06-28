class AddCampaignIdToMonster < ActiveRecord::Migration
  def change
    add_reference :monsters, :campaign, index: true
    add_foreign_key :monsters, :campaigns
    ActiveRecord::Base.connection.execute("update monsters m
                                          set campaign_id =
                                            (select campaign_id 
                                            from campaign_contents cc 
                                            where cc.content_id = m.id
                                                    and cc.content_type = 'Monster')");
  end
end
