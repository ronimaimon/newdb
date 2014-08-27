module Utils
  
  # Return the r_id from the params where there is use of the generic form: shared/_research
  def self.getRIdFromParams(params)
    if not params["r_e_id"] and not params["r_e_name"]
      return nil
    end
    @research_id = (params["r_e_id"])
    if (@research_id.nil? or @research_id.empty?)
      name_id = params["r_e_name"].split(":")
      @research_id = (name_id[1])  if (name_id.size ==2)
    end
    @research_id
  end
end 
