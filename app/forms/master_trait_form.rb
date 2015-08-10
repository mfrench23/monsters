class MasterTraitForm < AbstractForm
  def initialize(params=nil)
    @params = whitelisted_params(params)
  end

  private

  def whitelisted_params(params)
    params.require(:master_trait).permit(permitted_attributes)
  end

  def permitted_attributes
    [:name, :notes, :is_feature,
     page_references_attributes: [:id, :book_id, :pages, :_destroy],
     traits_in_meta_trait_attributes: [:id, :master_trait_id, :level, :notes, :_destroy],
     traits_attributes: [:id, :creature_id, :level, :notes, :_destroy]
    ]
  end
end
