require 'utils'
include Utils
class ResearchesController < ApplicationController
  # GET /researches
  # GET /researches.json
  def index
    @researches = [];
    if (params[:all])
      @researches = Research.paginate(:page => params[:page], :per_page => 20)
    elsif(not params[:id].blank?)
      
        @researches = Research.where("RESEARCH_ID = ?", params[:id]).paginate(:page => params[:page], :per_page => 20 )     
     
    elsif(not params[:search_name].blank?)
      @researches = Research.where(['RESEARCH_NAME LIKE ?', "%#{params[:search_name]}%"]).paginate(:page => params[:page], :per_page => 20)
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @researches }
    end
  end

  # GET /researches/1
  # GET /researches/1.json
  def show
    @research = Research.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @research }
    end
  end


  # GET /researches/1/edit
  def edit
    @research = Research.find(params[:id])
  end

  # POST /researches
  # POST /researches.json
  def create
    @research = Research.new(params[:research])

    respond_to do |format|
      if @research.save
        format.html { redirect_to @research, notice: 'Research was successfully created.' }
        format.json { render json: @research, status: :created, location: @research }
      else
        format.html { render action: "new" }
        format.json { render json: @research.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /researches/1
  # PUT /researches/1.json
  def update
    @research = Research.find(params[:id])

    respond_to do |format|
      if @research.update_attributes(params[:research])
        format.html { redirect_to @research, notice: 'Research was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @research.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /researches/1
  # DELETE /researches/1.json
  def destroy
    
    @research = Research.find(params[:id])
    @research.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end
  
  
  
end
