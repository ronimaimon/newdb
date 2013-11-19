class UtilsController < ApplicationController
  def getvalue
    @researches = []
    @r_hash = []
    if params[:term]
       @researches = Research.where(['RESEARCH_NAME LIKE ?', "%#{params[:term]}%"])
       @researches.each do |r|
          value = r.RESEARCH_NAME + ":" + r.RESEARCH_ID.to_s
          @r_hash << {"label" => value, "value"=> value}
       end
     end
  
     respond_to do |format|
       format.html
       format.json { render :json =>  @r_hash}
     end
  end
  
  def tags
    @tags = Tag.where("NAME LIKE ?", "%#{params["q"]}%")
    map = @tags.collect{|t| {:id => t.NAME, :name => t.NAME }}
    map << {:id => params["q"], :name => params["q"], :is_new=> true}
     respond_to do |format|
       format.json { render :json => map }
     end
    
  end
  
end
