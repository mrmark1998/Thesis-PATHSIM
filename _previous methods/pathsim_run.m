%load TEST2
%run pathtest to find bad paths

%TEST2(bad_idx,:)=[];

CASE_NUM=size(TEST2,1);
allscores =zeros(1e5,7);
allctr=0;
for idx=1:CASE_NUM
    NEIGHBOR_NUM=2;
    path1 = TEST2{idx,1};
    path2 = TEST2{idx,2};
    
    
    min_path_len = size(path1,1);
    if size(path2,1) < min_path_len
        min_path_len=size(path2,1);
    end
    
    if min_path_len < 2*NEIGHBOR_NUM+1
        % pathscores=[pathscores; path1(i,1) path1(i,2) path2(i,1) path2(i,2)  -1 -1 -1];
        continue
    end
    
    pathscores = [];
    for i = NEIGHBOR_NUM+1 : min_path_len - NEIGHBOR_NUM
        
        
        if path1(i,1) == path2(i,1) && path1(i,2) == path2(i,2)
           pathscores=[pathscores; path1(i,1) path1(i,2) path2(i,1) path2(i,2)  1 1 1];
        else
            subpath1 = path1(i-2:i+2,:);
            subpath2 = path2(i-2:i+2,:);
            [vscore,pscore] = pathsim_compare(subpath1,subpath2,POINTMRO,VECSIM_para,PCI_ID,DISCON_MAT);
            pscore_flat = pscore(:);
            pscore_flat(pscore_flat(:,1) < 0,:) = [];
            if isempty(pscore_flat)
                pscore_flat=[-1];
            else
                x=pscore_flat;
                a = unique(x);
                out = [a,histc(x(:),a)];
                max_freq = max(out(:,2));
                out(out(:,2) ~= max_freq,:) = [];
                avg_score = round(mean(out(:,1)));
            end
            pathscores=[pathscores; path1(i,1) path1(i,2) path2(i,1) path2(i,2)  vscore mode(pscore_flat(:)) avg_score];
   
        end
        
        
        
    end
    allscores(allctr+1:allctr+size(pathscores,1),:) = pathscores;
    allctr=allctr+size(pathscores,1);
    fprintf("FInished %d/%d cases\n",idx, CASE_NUM);
end

allscores(allctr+1:end,:)=[];
