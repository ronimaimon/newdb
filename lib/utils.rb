module Utils
  
  def getRIdFromParams(params)
    @research_id = (params["r_id"])
    if (@research_id.nil? or @research_id.empty? )
      name_id = params["r_name"].split(":")
      @research_id = (params["r_name"].split(":")[1])  if (name_id.size ==2)
    end
    @research_id
  end
end 
