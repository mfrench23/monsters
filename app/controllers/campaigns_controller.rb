class CampaignsController < ModelBasedController

  private

  def additional_form_locals
    { monsters: Monster.all }
  end

  def whitelisted_entity_params
    params.require(:campaign).permit(:name,
                                      campaign_contents_attributes: [:id, :content_id, :content_type, :_destroy])
  end
end
