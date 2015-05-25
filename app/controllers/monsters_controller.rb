class MonstersController < ApplicationController
  before_action :set_monster, only: [:show, :edit, :update, :destroy]

  helper_method :sortable

  # GET /monsters
  # GET /monsters.json
  def index
    @monsters = Monster.filter(params.slice(:starts_with)).order(sort_param).includes(:monster_names, :monster_class, characteristic_monsters: [:characteristic] ).page params[:page]
  end

  # GET /monsters/1
  # GET /monsters/1.json
  def show
  end

  # GET /monsters/new
  def new
    @monster = Monster.new
    @monster.build_out
  end

  # GET /monsters/1/edit
  def edit
  end

  # POST /monsters
  # POST /monsters.json
  def create
    form = MonsterForm.new(params)
    service = CreateMonster.new(form)
    @monster = service.call

    respond_to do |format|
      if @monster.errors.size() == 0
	format.html { redirect_to @monster, notice: 'Monster was successfully created.' }
	format.json { render :show, status: :created, location: @monster }
      else
	format.html { render :new }
	format.json { render json: @monster.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /monsters/1
  # PATCH/PUT /monsters/1.json
  def update
    form = MonsterForm.new(params)
    service = UpdateMonster.new(params[:id], form)
    @monster = service.call
    respond_to do |format|
      if @monster.errors.size() == 0
	format.html { redirect_to @monster, notice: 'Monster was successfully updated.' }
	format.json { render :show, status: :ok, location: @monster }
      else
	format.html { render :edit }
	format.json { render json: @monster.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /monsters/1
  # DELETE /monsters/1.json
  def destroy
    @monster.destroy
    respond_to do |format|
      format.html { redirect_to monsters_url, notice: 'Monster was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    view_context.link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_monster
    @monster = Monster.includes(:monster_names, :monster_class, characteristic_monsters: [:characteristic] ).find(params[:id])
  end

  def sort_param
    sort_column + " " + sort_direction
  end

  def sort_column
    Monster.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
