function vecsimscore = vecsim_comp_record(thismomentmro,thismomentmro2,towerloc, towerloc2, VECSIM_para)                        

    % simimlarity: 
    %    -- same PCI: Tadv, Powers to towers, RSRQ of towers, number of common PCI, number of distinct PCI, PHR, SceEuTxRxTD
    %    -- diff PCI: Powers to towers, RSRQ of towers, number of common PCI, number of distinct PCI
    
    vecsimscore.samePCI_flag  = thismomentmro(1,VECSIM_para.FD_idx_PCI) == thismomentmro2(1,VECSIM_para.FD_idx_PCI);
    if(vecsimscore.samePCI_flag ~=1)
        vecsimscore.score=-1;
        return;
    end
    [vecsimscore.data, vecsimscore.Tadv, vecsimscore.Plist] = vecsim_get_data_from_mro(thismomentmro,VECSIM_para);
    [vecsimscore.data2, vecsimscore.Tadv2, vecsimscore.Plist2] = vecsim_get_data_from_mro(thismomentmro2,VECSIM_para);
    vecsimscore.timediff = vecsimscore.data(VECSIM_para.FD_idx_TS) - vecsimscore.data2(VECSIM_para.FD_idx_TS);
    vecsimscore.commonPCI = intersect(vecsimscore.Plist(:,1), vecsimscore.Plist2(:,1));
    vecsimscore.commondiff = zeros(1,length(vecsimscore.commonPCI));
    vecsimscore.anglediff = angle(exp(1i*vecsimscore.data(VECSIM_para.FD_idx_AoA))/exp(1i*vecsimscore.data2(VECSIM_para.FD_idx_AoA)));
    for h1=1:length(vecsimscore.commonPCI)
        thisPCI = vecsimscore.commonPCI(h1);
        tempp = find(vecsimscore.Plist(:,1) == thisPCI); tempp = tempp(1);
        tempp2 = find(vecsimscore.Plist2(:,1) == thisPCI); tempp2 = tempp2(1);
        pval = vecsimscore.Plist(tempp,2);
        pval2 = vecsimscore.Plist2(tempp2,2);
        thisdiffP = abs(pval - pval2);
        if max(pval,pval2) > 0
            thisdiffP_norm = thisdiffP/max(pval,pval2);
        else
            thisdiffP_norm = 0;
        end
        vecsimscore.commondiff(h1) = thisdiffP_norm;
    end
    
    vecsimscore.uniquePCInum = [size(vecsimscore.Plist,1)-length(vecsimscore.commonPCI),size(vecsimscore.Plist2,1)-length(vecsimscore.commonPCI)];
    [dummy,idx] = ismember(vecsimscore.commonPCI,vecsimscore.Plist(:,1)'); 
    diffidx = setdiff([1:size(vecsimscore.Plist,1)], idx);
    vecsimscore.uniqueP = vecsimscore.Plist(diffidx,2);
    [dummy,idx2] = ismember(vecsimscore.commonPCI,vecsimscore.Plist2(:,1)'); 
    diffidx2 = setdiff([1:size(vecsimscore.Plist2,1)], idx2);
    vecsimscore.uniqueP2 = vecsimscore.Plist2(diffidx2,2);
    otherlist = [vecsimscore.uniqueP;vecsimscore.uniqueP2];
    
    x_Tadv = abs(vecsimscore.Tadv - vecsimscore.Tadv2);
    vecsimscore.x_Tadv = x_Tadv;
    TadvConst = 78;
    thisadiff = abs(vecsimscore.anglediff);
    x1 = vecsimscore.Tadv; 
    x2 = vecsimscore.Tadv2;
    thisestdist = sqrt(x1*x1+x2*x2-2*cos(thisadiff)*x1*x2)*TadvConst;
    vecsimscore.estdist = thisestdist;
    
    DIST_STEP = 25;
    distvals = [1:8]*DIST_STEP; % within 25, 25 to 50,..., 175 to infinity
    samePCI_Tadv_diff_max = 7;
    distprob_samePCI = VECSIM_para.simpdf.Tadv(:,1:samePCI_Tadv_diff_max);
    
    scores = ones(length(distvals),5); % likelihood values
    score_idx_Tadv = 1;
    score_idx_AoA = 2;
    score_idx_PCI = 3;
    score_idx_uniquehear = 4;
    score_idx_RSRP = 5;

    distestidx = min(ceil(thisestdist/DIST_STEP+0.000001),size(scores,1));
    scores(:,score_idx_Tadv) = 0;
    scores(distestidx,score_idx_Tadv) = 0.8;
    distestidx_min = max(1,distestidx-1);
    distestidx_max = min(size(scores,1),distestidx+1);
    scores(distestidx_min,score_idx_Tadv) = scores(distestidx_min,score_idx_Tadv) + 0.1;
    scores(distestidx_max,score_idx_Tadv) = scores(distestidx_max,score_idx_Tadv) + 0.1;
    
    for distidx=1:length(distvals)
        
        if ~isempty(vecsimscore.commonPCI) % NOTE: not used
            x_PCIset = mean(vecsimscore.uniquePCInum)/length(vecsimscore.commonPCI);
            % y_PCIset = exp((-x_PCIset*3/distidx));
            % x_PCIset = min(ceil(x_PCIset*20+0.01), size(VECSIM_para.gammadist,2)-1);
            % y_PCIset = VECSIM_para.gammadist(distidx,x_PCIset+1);
            y_PCIset = VECSIM_para.simpdf.unqiue(distidx,min(size(VECSIM_para.simpdf.unqiue,2),round(x_PCIset*10)+1));
            % scores(distidx,score_idx_PCI) = y_PCIset;
            vecsimscore.x_PCIset = x_PCIset;
        end

        if ~isempty(otherlist)
            if length(otherlist) == 1
                l_PCIset = otherlist(1);
            else
                a = sort(otherlist);
                l_PCIset = round(mean(a(end-1:end)));
            end
            l_PCIset = min(l_PCIset, size(VECSIM_para.gammadist,2)-1);
            if l_PCIset > 20
                % y_uniquehear = VECSIM_para.gammadist(distidx,l_PCIset-20);
                % fprintf(1,'%d %d\n', distidx, l_PCIset+1)
                y_uniquehear = VECSIM_para.simpdf.otherhigh(distidx,l_PCIset+1);
                scores(distidx,score_idx_uniquehear) = y_uniquehear;
            end
            vecsimscore.l_PCIset = l_PCIset;
        else
            y_uniquehear = VECSIM_para.simpdf.otherhigh(distidx,1);
            scores(distidx,score_idx_uniquehear) = y_uniquehear;
            vecsimscore.l_PCIset = 0;
        end

        if ~isempty(vecsimscore.commonPCI)
            % NOTE: low x, like 0.05, higher, like 0.5. some list has only 1,
            % should be more common numbers, more linient
            rawscores = zeros(1,length(vecsimscore.commondiff));
            for h1=1:length(vecsimscore.commondiff)
                x_RSRP = vecsimscore.commondiff(h1);
                l_RSRP = floor(x_RSRP*(size(VECSIM_para.gammadist_rsrp,2)-1));
                rawscores(h1) = VECSIM_para.gammadist_rsrp(distidx,l_RSRP+1);
            end
            y_RSRP = power(prod(rawscores),1/length(rawscores));
            scores(distidx,score_idx_RSRP) = y_RSRP;
        end
    end
        
    vecsimscore.detailedscore = scores;
    vecsimscore.gotpdf = prod(scores');
    [a,b] = max(vecsimscore.gotpdf);
    if a > 0
        vecsimscore.score = b; 
    else
        vecsimscore.score = length(distvals); 
    end        
end



function [vecsimdata, Tadv, Plist_res] = vecsim_get_data_from_mro(thismomentmro,VECSIM_para)
    if 0
        powermeanoise = round(5*randn(size(thismomentmro,1)+1,1));
        thismomentmro(:,VECSIM_para.FD_idx_RSRP) = max(thismomentmro(:,VECSIM_para.FD_idx_RSRP) + powermeanoise(1),1);
        thismomentmro(:,VECSIM_para.FD_idx_nRSRP) = thismomentmro(:,VECSIM_para.FD_idx_nRSRP) + powermeanoise(2:end);
        tempp = find(thismomentmro(:,VECSIM_para.FD_idx_nRSRP) < 1); thismomentmro(tempp,VECSIM_para.FD_idx_nRSRP) = 1;
    end
    
    vecsimdata = thismomentmro(1,1:VECSIM_para.FD_idx_SceEuTxRxTD);
    nPCIdaataRaw = thismomentmro(:,VECSIM_para.FD_idx_nPCI:VECSIM_para.FD_idx_nRSRQ);
    [a,b] = sort(nPCIdaataRaw(:,1));
    nPCIdaata = nPCIdaataRaw(b,:);
    badidx = nPCIdaataRaw(:,1) == -1;
    nPCIdaataRaw(badidx,:) = [];
    badidx = nPCIdaataRaw(:,2) == -1;
    nPCIdaataRaw(badidx,:) = [];
    vecsimdata = [vecsimdata, reshape(nPCIdaata',1,numel(nPCIdaata))];
    Tadv = thismomentmro(1,VECSIM_para.FD_idx_Tadv);
    Plist = [thismomentmro(1,[VECSIM_para.FD_idx_PCI,VECSIM_para.FD_idx_RSRP,VECSIM_para.FD_idx_RSRQ])];
    Plist = [Plist; nPCIdaataRaw];
    [a,b] = sort(Plist(:,1));
    Plist = Plist(b,:);
    Plist_res = [];
    unqiuePCIlist = unique(Plist(:,1));
    for h=1:length(unqiuePCIlist)
        hereallidx = find(Plist(:,1) == unqiuePCIlist(h));
        if length(hereallidx) == 1
            hereval = Plist(hereallidx,:);
        else
            hereval = mean(Plist(hereallidx,:));
        end
        hererecord = [unqiuePCIlist(h),hereval(2:3)];
        Plist_res= [Plist_res; hererecord];
    end
end
