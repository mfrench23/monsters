# Controller functionality specific to the Campaign model
class CampaignsController < ModelBasedController

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
