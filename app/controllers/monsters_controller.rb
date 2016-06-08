# Controller functionality specific to the Monster model
class MonstersController < ModelBasedController

  def show
    redirect_to set_model_by_id.specific
  end

  private

  def additional_index_locals
    {campaigns: all_campaigns_with_monsters.order_by_name}
  end

  def includes_for_sorting
    [:monster_names, :monster_class]
  end

  def all_campaigns_with_monsters
    Campaign.has_contents(Monster.to_s)
  end

  def acceptable_filter_scopes
    [:starting_with, :created_on, :updated_on, :in_campaign]
  end
end
