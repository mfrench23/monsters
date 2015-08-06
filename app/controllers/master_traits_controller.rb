class MasterTraitsController < ModelBasedController
  # GET /master_traits/1/merge_into
  def merge_into
    display_merge_into_page
  end

  # POST /master_traits/1/merge_into
  def do_merge_into
    merge_into = MasterTrait.find(params[:merge_into_trait_id])
    redirect_after_merge merge_into.merge(set_model_by_id), merge_into
  end

  private

  def redirect_after_merge(successful, merged_into)
    if successful
      redirect_to merged_into, notice: 'Master traits were successfully merged.'
    else
      display_merge_into_page 'Unable to merge.'
    end
  end

  def whitelisted_entity_params
    MasterTraitForm.new(params).params
  end

  def display_merge_into_page(notice=nil)
    mt = set_model_by_id
    render :merge_into, locals: {
      :master_trait => mt,
      :selection_list => MasterTrait.where("id != '#{mt.id}'").order_by_name
    }, notice: notice
  end

  def acceptable_filter_scopes
    [:starting_with]
  end
end
