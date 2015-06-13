class MonsterClassesController < ApplicationController
  # GET /monster_classes
  # GET /monster_classes.json
  def index
    render locals: {
      monster_classes: MonsterClass.order(view_context.sort_param(MonsterClass, params[:sort], params[:direction])).page( params[:page] )
    }
  end

  # GET /monster_classes/1
  # GET /monster_classes/1.json
  def show
    render locals: { monster_class: set_monster_class }
  end

  # GET /monster_classes/new
  def new
    monster_class = MonsterClass.new
    render locals: { monster_class: monster_class }
  end

  # GET /monster_classes/1/edit
  def edit
    render locals: { monster_class: set_monster_class }
  end

  # POST /monster_classes
  # POST /monster_classes.json
  def create
    monster_class = MonsterClass.new(monster_class_params)

    respond_to do |format|
      if monster_class.save
        format.html { redirect_to monster_class, notice: 'Monster class was successfully created.' }
        format.json { render :show, status: :created, location: monster_class }
      else
        format.html { render :new, locals: {monster_class: monster_class} }
        format.json { render json: monster_class.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /monster_classes/1
  # PATCH/PUT /monster_classes/1.json
  def update
    monster_class = set_monster_class
    respond_to do |format|
      if monster_class.update(monster_class_params)
        format.html { redirect_to monster_class, notice: 'Monster class was successfully updated.' }
        format.json { render :show, status: :ok, location: monster_class }
      else
        format.html { render :edit, locals: {monster_class: monster_class} }
        format.json { render json: monster_class.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /monster_classes/1
  # DELETE /monster_classes/1.json
  def destroy
    set_monster_class.destroy
    respond_to do |format|
      format.html { redirect_to monster_classes_url, notice: 'Monster class was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_monster_class
      MonsterClass.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def monster_class_params
      params.require(:monster_class).permit(:name)
    end
end
