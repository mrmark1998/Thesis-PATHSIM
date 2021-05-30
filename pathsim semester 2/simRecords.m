function issimilar = simRecords(thisrecord,nextrecord,VECSIM_para)

    %0  : not similar
    %1  : similar
    
    %thisrecord struct
    %MRO1
    %MRO2
    %loc1
    %loc2
    %score
    
    issimilar = 0;
    AoAthresh = pi/4;
    RSRPthresh = 20;
    scorethresh=2;
    %check if aoa difference is > pi/4 or rsrp diff > 20
    
    if abs(thisrecord.MRO1(1,VECSIM_para.FD_idx_RSRP) - nextrecord.MRO1(1,VECSIM_para.FD_idx_RSRP)) > RSRPthresh
        return
    end
    if abs(thisrecord.MRO2(1,VECSIM_para.FD_idx_RSRP) - nextrecord.MRO2(1,VECSIM_para.FD_idx_RSRP) ) > RSRPthresh
        return
    end
    if abs(thisrecord.MRO1(1,VECSIM_para.FD_idx_AoA) - nextrecord.MRO1(1,VECSIM_para.FD_idx_AoA)) > AoAthresh
        return
    end
    if abs(thisrecord.MRO2(1,VECSIM_para.FD_idx_AoA) - nextrecord.MRO2(1,VECSIM_para.FD_idx_AoA)) > AoAthresh
        return
    end
    
    %now compute vecsim, if larger than 3, return not similar
    mro1score = vecsim_comp_record(thisrecord.MRO1,nextrecord.MRO1,0, 0, VECSIM_para);
    if mro1score > scorethresh
        return
    end
    
    mro2score = vecsim_comp_record(thisrecord.MRO2,nextrecord.MRO2,0, 0, VECSIM_para);
    if mro2score > scorethresh
        return
    end
    
    %otherwise return 1
    issimilar =1;
    
    
    
  
        
end