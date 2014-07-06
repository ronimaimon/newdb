
module CombinedMeasure
  def self.addCombinedMeasures(measures)
    measures.each do |subjectMeasureMap|
      subjectMeasureMap["CPT_task_score_old"] = calcCPTTaskScore(subjectMeasureMap,"CPT");
      subjectMeasureMap["CPTi_task_score_old"] = calcCPTTaskScore(subjectMeasureMap,"CPTi");
      subjectMeasureMap["ACPT_task_score_old"] = calcCPTTaskScore(subjectMeasureMap,"ACPT");
      subjectMeasureMap["StroopLike_task_score_old"] = calcStroopLikeTaskScore(subjectMeasureMap);
      subjectMeasureMap["Search_task_score_old"] = calcSearchTaskScore(subjectMeasureMap);
      
      subjectMeasureMap["PosnerTemporalCue_cost_old"] = calcPosnerCombinedMeasure(subjectMeasureMap,"PosnerTemporalCue","invalid","neutral");
      subjectMeasureMap["PosnerTemporalCue_benefit_old"] = calcPosnerCombinedMeasure(subjectMeasureMap,"PosnerTemporalCue","neutral","valid");
      subjectMeasureMap["PosnerTemporalCue_cost_left_old"] = calcPosnerCombinedMeasure(subjectMeasureMap,"PosnerTemporalCue","invalid_left_target","neutral_left_target");
      subjectMeasureMap["PosnerTemporalCue_benefit_left_old"] = calcPosnerCombinedMeasure(subjectMeasureMap,"PosnerTemporalCue","neutral_left_target","valid_left_target");
      subjectMeasureMap["PosnerTemporalCue_cost_right_old"] = calcPosnerCombinedMeasure(subjectMeasureMap,"PosnerTemporalCue","invalid_right_target","neutral_right_target");
      subjectMeasureMap["PosnerTemporalCue_benefit_right_old"] = calcPosnerCombinedMeasure(subjectMeasureMap,"PosnerTemporalCue","neutral_right_target","valid_right_target");
      
      subjectMeasureMap["PosnerTemporalCue_task_score_old"] = calcPosnerCombinedMeasure(subjectMeasureMap,"PosnerTemporalCue","invalid","valid");
      subjectMeasureMap["Posner_task_score_old"] = calcPosnerCombinedMeasure(subjectMeasureMap,"Posner","invalid","valid");
      subjectMeasureMap["PosnerTemporalCue_task_score_left_old"] = calcPosnerCombinedMeasure(subjectMeasureMap,"PosnerTemporalCue","invalid_left_target","valid_left_target");
      subjectMeasureMap["Posner_task_score_left_old"] = calcPosnerCombinedMeasure(subjectMeasureMap,"Posner","invalid_left_target","valid_left_target");
      subjectMeasureMap["PosnerTemporalCue_task_score_right_old"] = calcPosnerCombinedMeasure(subjectMeasureMap,"PosnerTemporalCue","invalid_right_target","valid_right_target");
      subjectMeasureMap["Posner_task_score_right_old"] = calcPosnerCombinedMeasure(subjectMeasureMap,"Posner","invalid_right_target","valid_right_target");
    end
   return measures
  end

  def self.calcStandardCombinedDifference( rt_first, acc_first,  rt_second,  acc_second)
    if (acc_first==0 || acc_second ==0)
      return 0.0;
    end
    adjustedRTInvalid = rt_first/acc_first;
    adjustedRTValid = rt_second/acc_second;
    meanAdjusted = (adjustedRTInvalid+adjustedRTValid)/2;
    if meanAdjusted==0
    return 0.0;
    end

    return (adjustedRTInvalid-adjustedRTValid)/meanAdjusted;
  end

  def self.calcCPTTaskScore(measureResultsMap,taskName)
    std_rt_clean_3std = measureResultsMap[taskName+"_std_rt_3std_clean"]
    avg_rt_clean_3std = measureResultsMap[taskName+"_avg_rt_3std_clean"]
    
    begin
      result =  std_rt_clean_3std / avg_rt_clean_3std
    rescue
      return nil
    else
      return result
    end
  end

  def self.calcPosnerCombinedMeasure(measureResultsMap,taskName,firstSuffix,secondSuffix)
    rt_first = measureResultsMap[taskName+ "_avg_rt_"+ firstSuffix];
    acc_first = measureResultsMap[taskName + "_acc_rate_"+ firstSuffix];

    rt_second = measureResultsMap[taskName + "_avg_rt_"+secondSuffix];
    acc_second = measureResultsMap[taskName + "_acc_rate_" + secondSuffix];
    begin
      result =  calcStandardCombinedDifference(rt_first, acc_first, rt_second, acc_second);
    rescue
      return nil
    else
      return result
    end
  end

  def self.calcSearchTaskScore(measureResultsMap)
    rt8 = measureResultsMap["Search_avg_rt_8s_wt"]
    rt16 = measureResultsMap["Search_avg_rt_16s_wt"]
    rt32 = measureResultsMap["Search_avg_rt_32s_wt"]

    acc8 = measureResultsMap["Search_acc_rate_8s_wt"]
    acc16 = measureResultsMap["Search_acc_rate_16s_wt"]
    acc32 = measureResultsMap["Search_acc_rate_32s_wt"]
    if(acc8==0 || acc16 ==0 || acc32==0)
    return 0.0;
    end
    begin
      adj8 = rt8/acc8;
      adj16 = rt16/acc16;
      adj32 = rt32/acc32;
  
      leftNumerator =  3*((8*adj8)+(16*adj16)+(32*adj32));
      rightNumerator = (8+16+32)*(adj8+adj16+adj32);
      numerator = leftNumerator-rightNumerator;
      denominator = 3.0*((8*8)+(16*16)+(32*32)) - ((8+16+32)*(8+16+32));
    rescue 
      return nil
    else
      return numerator/denominator;
    end
  end


  def self.calcStroopLikeTaskScore(measureResultsMap)
    rtDirInc = measureResultsMap["StroopLike_avg_rt_direction_incong"];
    rtLocInc = measureResultsMap["StroopLike_avg_rt_location_incong"];

    accDirInc = measureResultsMap["StroopLike_acc_rate_direction_incong"];
    accLocInc = measureResultsMap["StroopLike_acc_rate_location_incong"];

    rtDirCon = measureResultsMap["StroopLike_avg_rt_direction_cong"];
    rtLocCon = measureResultsMap["StroopLike_avg_rt_location_cong"];

    accDirCon = measureResultsMap["StroopLike_acc_rate_direction_cong"]
    accLocCon = measureResultsMap["StroopLike_acc_rate_location_cong"]

    begin
    combinedInc = (rtDirInc/accDirInc)+(rtLocInc/accLocInc);
    combinedCon = (rtDirCon/accDirCon)+(rtLocCon/accLocCon);

    numerator = combinedInc - combinedCon;
    denominator = (combinedCon+combinedInc)/2;
    result =  numerator/denominator;
    rescue 
      return nil
    else
      return result
    end
  end

end