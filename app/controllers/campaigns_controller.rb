# Controller functionality specific to the Campaign model
class CampaignsController < ModelBasedController

  def randomize
    target = RandomEquipmentService.new.randomize(Campaign.find(selected_campaign_id))
    saved = target.try(:save)
    redirect_to target, notice: 'Randomly generated.' if saved
    redirect_to :back, notice: 'Was not able to generate random equipment.' unless saved
  end

  def set_selected_campaign
    id = params[:campaign_id]
    cookies.permanent[:selected_campaign] = id
    head :ok, content_type: "text/html"
  end

  private

  def additional_form_locals
    { monsters: Monster.all.order_by_name }
  end

  def whitelisted_entity_params
    params.require(:campaign).permit(:name)
  end
end
