class MasterSkillsController < ApplicationController
  # GET /master_skills
  # GET /master_skills.json
  def index
    render locals: {
      master_skills: filtered_sorted_paginated_results,
      starts_with_tags: first_characters_in_results(filtered_results(params)),
      campaign_name: name_of_filtering_campaign,
      filter_params: filter_params(params)
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
    master_skill = MasterSkill.new(MasterSkillForm.new(params).params)

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
      if master_skill.update(MasterSkillForm.new(params).params)
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

  def filtered_sorted_paginated_results
    filtered_sorted_results(params).page( params[:page] )
  end

  def filtered_sorted_results(params)
    filtered_results(params).includes(:characteristic).order(view_context.sort_param(MasterSkill, params[:sort], params[:direction]))
  end

  def filtered_results(params)
    MasterSkill.filter(filter_params(params))
  end

  def filter_params(params)
    params.slice(:starting_with)
  end

  def set_master_skill
    MasterSkill.find(params[:id])
  end
end
