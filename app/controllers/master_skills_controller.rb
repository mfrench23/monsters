class MasterSkillsController < ApplicationController
  before_action :set_master_skill, only: [:show, :edit, :update, :destroy]

  # GET /master_skills
  # GET /master_skills.json
  def index
    @master_skills = MasterSkill.order(:name).includes(:characteristic).page params[:page]
  end

  # GET /master_skills/1
  # GET /master_skills/1.json
  def show
  end

  # GET /master_skills/new
  def new
    @master_skill = MasterSkill.new
  end

  # GET /master_skills/1/edit
  def edit
  end

  # POST /master_skills
  # POST /master_skills.json
  def create
    @master_skill = MasterSkill.new(master_skill_params)

    respond_to do |format|
      if @master_skill.save
        format.html { redirect_to @master_skill, notice: 'Master skill was successfully created.' }
        format.json { render :show, status: :created, location: @master_skill }
      else
        format.html { render :new }
        format.json { render json: @master_skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /master_skills/1
  # PATCH/PUT /master_skills/1.json
  def update
    respond_to do |format|
      if @master_skill.update(master_skill_params)
        format.html { redirect_to @master_skill, notice: 'Master skill was successfully updated.' }
        format.json { render :show, status: :ok, location: @master_skill }
      else
        format.html { render :edit }
        format.json { render json: @master_skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /master_skills/1
  # DELETE /master_skills/1.json
  def destroy
    @master_skill.destroy
    respond_to do |format|
      format.html { redirect_to master_skills_url, notice: 'Master skill was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_master_skill
      @master_skill = MasterSkill.includes(:characteristic).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def master_skill_params
      params.require(:master_skill).permit(:name, :characteristic_id, :notes, :requires_specialization)
    end
end
