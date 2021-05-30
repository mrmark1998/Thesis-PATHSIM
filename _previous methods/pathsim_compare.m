function [vscore,pscore] = pathsim_compare(subpath1,subpath2,POINTMRO,VECSIM_para,PCI_ID,DISCON_MAT)

USE_DISCON_MAT=1;
pscore = zeros(size(subpath1,1),size(subpath2,1));

for i=1:size(subpath1,1) % 5 pairs of x,y 
    thismro = POINTMRO{subpath1(i,1),subpath1(i,2)}.mro;

    for j=1:size(subpath2,1) % 5 pairs of x,y
        nextmro = POINTMRO{subpath2(i,1),subpath2(i,2)}.mro;
        simscore = vecsim_comp_record(thismro, nextmro, 0, 0, VECSIM_para);
        if simscore.score <= 4 || USE_DISCON_MAT == 0
            pscore(i,j) = simscore.score;
        else
            lookupscore = lookup_pair(thismro,nextmro,VECSIM_para,PCI_ID,DISCON_MAT);
            if lookupscore == 1
                pscore(i,j) = 1;
                %fprintf(" found pair\n");
            else
                pscore(i,j) = simscore.score;
            end
        end
        
    end
    
end

vscore =pscore(round(size(pscore,1)/2),round(size(pscore,1)/2));
