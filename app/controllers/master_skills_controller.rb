class MasterSkillsController < ApplicationController
  # GET /master_skills
  # GET /master_skills.json
  def index
    render locals: {
      master_skills: MasterSkill.includes(:characteristic).order(view_context.sort_param(MasterSkill, params[:sort], params[:direction])).page( params[:page] )
    }
  end

  # GET /master_skills/1
  # GET /master_skills/1.json
  def show
    render locals: { master_skill: set_master_skill }
  end

  # GET /master_skills/new
  def new
    render locals: { master_skill: MasterSkill.new }
  end

  # GET /master_skills/1/edit
  def edit
    render locals: { master_skill: set_master_skill }
  end

  # POST /master_skills
  # POST /master_skills.json
  def create
    master_skill = MasterSkill.new(master_skill_params)

    respond_to do |format|
      if master_skill.save
        format.html { redirect_to master_skill, notice: 'Master skill was successfully created.' }
        format.json { render :show, status: :created, location: master_skill }
      else
        format.html { render :new, locals: {master_skill: master_skill} }
        format.json { render json: master_skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /master_skills/1
  # PATCH/PUT /master_skills/1.json
  def update
    master_skill = set_master_skill
    respond_to do |format|
      if master_skill.update(master_skill_params)
        format.html { redirect_to master_skill, notice: 'Master skill was successfully updated.' }
        format.json { render :show, status: :ok, location: master_skill }
      else
        format.html { render :edit, locals: {master_skill: master_skill} }
        format.json { render json: master_skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /master_skills/1
  # DELETE /master_skills/1.json
  def destroy
    set_master_skill.destroy
    respond_to do |format|
      format.html { redirect_to master_skills_url, notice: 'Master skill was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_master_skill
      MasterSkill.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def master_skill_params
      params.require(:master_skill).permit(:name, :characteristic_id, :notes,
                                           :requires_specialization, :requires_tech_level)
    end
end
