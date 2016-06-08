# Organizes the collection of parameters for a single instance of the MasterSkill model
class MasterSkillForm < AbstractForm
  def initialize(params=nil)
    @params = whitelisted_params(params)
  end

  private

  def whitelisted_params(params)
    params.require(:master_skill).permit( permitted_attributes )
  end

  def permitted_attributes
    [:name, :characteristic_id, :notes,
     :requires_specialization, :requires_tech_level,
     page_references_attributes: [:id, :book_id, :pages, :_destroy]
    ]
  end
end
