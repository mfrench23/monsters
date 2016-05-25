class RemoveNotesFromCampaignContents < ActiveRecord::Migration
  def change
    remove_column :campaign_contents, :notes, :text
  end
end
