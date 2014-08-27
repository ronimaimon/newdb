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
    tag = params["q"]
    contains_value = false
    if params["q"].include?('=')
     contains_value = true
     tag = params["q"].slice(0..(params["q"].index('=')-1))
    end
    @tags = Tag.where("NAME LIKE ?", "%#{tag}%")
    map = @tags.collect{|t| {:id => t.NAME, :name => t.NAME }}
    if !contains_value
      map << {:id => params["q"], :name => params["q"], :is_new=> true}
    else
      puts "here3"
      if @tags.size == 0
        map = [{:id => params["q"], :name => params["q"], :is_new=> true}]
      elsif @tags.first.NAME == tag
        map = [{:id => params["q"], :name => params["q"]}]
      else
        map = [{:id => params["q"], :name => params["q"], :is_new=> true}]
      end
    end
     respond_to do |format|
       format.json { render :json => map }
     end
    
  end
  
end
