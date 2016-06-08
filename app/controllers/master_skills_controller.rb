# Controller functionality specific to the MasterSkill model
class MasterSkillsController < ModelBasedController

  private

  def whitelisted_entity_params
    MasterSkillForm.new(params).params
  end

  def includes_for_sorting
    [:characteristic]
  end

  def acceptable_filter_scopes
    [:starting_with]
  end
end
