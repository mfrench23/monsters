class PageReferencesController < ApplicationController
  before_action :set_page_reference, only: [:show, :edit, :update, :destroy]

  # GET /page_references
  # GET /page_references.json
  def index
    @page_references = PageReference.all
  end

  # GET /page_references/1
  # GET /page_references/1.json
  def show
  end

  # GET /page_references/new
  def new
    @page_reference = PageReference.new
  end

  # GET /page_references/1/edit
  def edit
  end

  # POST /page_references
  # POST /page_references.json
  def create
    @page_reference = PageReference.new(page_reference_params)

    respond_to do |format|
      if @page_reference.save
        format.html { redirect_to @page_reference, notice: 'Page reference was successfully created.' }
        format.json { render :show, status: :created, location: @page_reference }
      else
        format.html { render :new }
        format.json { render json: @page_reference.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /page_references/1
  # PATCH/PUT /page_references/1.json
  def update
    respond_to do |format|
      if @page_reference.update(page_reference_params)
        format.html { redirect_to @page_reference, notice: 'Page reference was successfully updated.' }
        format.json { render :show, status: :ok, location: @page_reference }
      else
        format.html { render :edit }
        format.json { render json: @page_reference.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /page_references/1
  # DELETE /page_references/1.json
  def destroy
    @page_reference.destroy
    respond_to do |format|
      format.html { redirect_to page_references_url, notice: 'Page reference was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page_reference
      @page_reference = PageReference.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_reference_params
      params.require(:page_reference).permit(:book_id, :monster_id, :pages)
    end
end
