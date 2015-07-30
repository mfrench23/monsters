class PopulateCampaignContent < ActiveRecord::Migration
  class CampaignContent < ActiveRecord::Base
  end

  class CampaignMonster < ActiveRecord::Base
  end

  def up
    CampaignMonster.all.each do |campaign_monster|
      content = CampaignContent.new({:campaign_id => campaign_monster.campaign_id,
                                     :content_id => campaign_monster.monster_id,
                                     :content_type => 'Monster' })
      content.save
    end
  end

  def down
    CampaignContent.delete_all
  end
end
