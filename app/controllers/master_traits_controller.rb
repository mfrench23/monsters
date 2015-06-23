class MasterTraitsController < ApplicationController
  # GET /master_traits
  # GET /master_traits.json
  def index
    params[:sort] ||= "master_traits.name, master_traits.notes"
    render locals: {
      master_traits: MasterTrait.order(view_context.sort_param(MasterTrait, params[:sort], params[:direction])).page( params[:page] )
    }
  end

  # GET /master_traits/1
  # GET /master_traits/1.json
  def show
    render locals: { master_trait: set_master_trait }
  end

  # GET /master_traits/new
  def new
    master_trait = MasterTrait.new
    render locals: { master_trait: master_trait }
  end

  # GET /master_traits/1/edit
  def edit
    render locals: { master_trait: set_master_trait }
  end

  def merge_into
    def show_merge_into(notice=nil)
      mt = set_master_trait
      render :merge_into, locals: {
        :master_trait => mt,
        :selection_list => MasterTrait.where("id != '#{mt.id}'").order(:name)
      }, notice: notice
    end

    if params[:merge_into_trait_id]
      into = MasterTrait.find(params[:merge_into_trait_id])
      if into.merge(set_master_trait)
        redirect_to into, notice: 'Master traits were successfully merged.'
      else
        show_merge_into 'Unable to merge.'
      end
    else
      show_merge_into
    end
  end

  # POST /master_traits
  # POST /master_traits.json
  def create
    master_trait = MasterTrait.new(master_trait_params)

    respond_to do |format|
      if master_trait.save
        format.html { redirect_to master_trait, notice: 'Master trait was successfully created.' }
        format.json { render :show, status: :created, location: master_trait }
      else
        format.html { render :new, locals: {master_trait: master_trait} }
        format.json { render json: master_trait.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /master_traits/1
  # PATCH/PUT /master_traits/1.json
  def update
    master_trait = set_master_trait
    respond_to do |format|
      if master_trait.update(master_trait_params)
        format.html { redirect_to master_trait, notice: 'Master trait was successfully updated.' }
        format.json { render :show, status: :ok, location: master_trait }
      else
        format.html { render :edit, locals: {master_trait: master_trait} }
        format.json { render json: master_trait.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /master_traits/1
  # DELETE /master_traits/1.json
  def destroy
    set_master_trait.destroy
    respond_to do |format|
      format.html { redirect_to master_traits_url, notice: 'Master trait was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_master_trait
      MasterTrait.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def master_trait_params
      params.require(:master_trait).permit(:name, :notes, :is_feature,
                                           traits_in_meta_trait_attributes: [:id, :master_trait_id, :level, :notes, :_destroy],
                                           traits_attributes: [:id, :creature_id, :level, :notes, :_destroy])
    end
end
