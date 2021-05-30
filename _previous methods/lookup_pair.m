
function [lookupscore] = lookup_pair(MRO1,MRO2,VECSIM_para,PCI_ID,DISCON_MAT)

%codes
% 0 - checked db no pair found
% -1 - checked db arr was empty
% 1 - checked db found similar


    lookupscore = -1;
    matx = MRO1(1,VECSIM_para.FD_idx_Tadv)+1;
    maty = MRO2(1,VECSIM_para.FD_idx_Tadv)+1;
    matz = find(PCI_ID == MRO1(1,VECSIM_para.FD_idx_PCI));
    
    if isempty(DISCON_MAT{matx,maty,matz})
        return ;
    end
    
    records = DISCON_MAT{matx,maty,matz}.arr;
    rlen = DISCON_MAT{matx,maty,matz}.len;
    thisrecord.MRO1=MRO1;
    thisrecord.MRO2=MRO2;
    testarr= zeros(length(records),7);
    lookupscore = 0;
    for ridx = 1:rlen
        nextrecord = records(ridx);
        testarr(ridx,1:2) = nextrecord.loc1;
        testarr(ridx,3:4) = nextrecord.loc2;
        
        issimilar = simRecords(thisrecord,nextrecord,VECSIM_para);
        testarr(ridx,5:7) = issimilar;
        if issimilar == 1
            lookupscore=1;
            break;
        end
    end


end