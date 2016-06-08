# Controller functionality specific to the Swarm model
class SwarmsController < ModelBasedController
  def index
    redirect_to monsters_url
  end

  def variant
    swarm = Swarm.find(params[:id]).deep_copy
    render :new, locals: { swarm: swarm, campaigns: all_campaigns }
  end

  private

  def whitelisted_entity_params
    SwarmForm.new(params).params
  end

  def additional_form_locals
    {campaigns: all_campaigns}
  end
end
