class MasterTraitsController < ApplicationController
  before_action :set_master_trait, only: [:show, :edit, :merge_into, :update, :destroy]

  # GET /master_traits
  # GET /master_traits.json
  def index
    @master_traits = MasterTrait.order(:name, :notes).page params[:page]
  end

  # GET /master_traits/1
  # GET /master_traits/1.json
  def show
  end

  # GET /master_traits/new
  def new
    @master_trait = MasterTrait.new
  end

  # GET /master_traits/1/edit
  def edit
  end

  def merge_into
    if params[:merge_into_trait_id]
      into = MasterTrait.find(params[:merge_into_trait_id])
      if into.merge(@master_trait)
        redirect_to into, notice: 'Master traits were successfully merged.'
      else
        render :merge_into
      end
    end
  end

  # POST /master_traits
  # POST /master_traits.json
  def create
    @master_trait = MasterTrait.new(master_trait_params)

    respond_to do |format|
      if @master_trait.save
        format.html { redirect_to @master_trait, notice: 'Master trait was successfully created.' }
        format.json { render :show, status: :created, location: @master_trait }
      else
        format.html { render :new }
        format.json { render json: @master_trait.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /master_traits/1
  # PATCH/PUT /master_traits/1.json
  def update
    respond_to do |format|
      if @master_trait.update(master_trait_params)
        format.html { redirect_to @master_trait, notice: 'Master trait was successfully updated.' }
        format.json { render :show, status: :ok, location: @master_trait }
      else
        format.html { render :edit }
        format.json { render json: @master_trait.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /master_traits/1
  # DELETE /master_traits/1.json
  def destroy
    @master_trait.destroy
    respond_to do |format|
      format.html { redirect_to master_traits_url, notice: 'Master trait was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_master_trait
      @master_trait = MasterTrait.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def master_trait_params
      params.require(:master_trait).permit(:name, :notes, :is_feature)
    end
end
