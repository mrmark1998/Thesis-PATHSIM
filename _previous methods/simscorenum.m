x = size(coord1,1)

y = size(coord2,1)

if(x>y)
    z=floor(x/y);
else
    z=floor(y/x);
end    

for i = 1:x

    MRO1 = POINTMRO{coord1(i,1),coord1(i,2)}.mro;

    MRO2 = POINTMRO{coord2(i*z,1),coord2(i*z,2)}.mro;

    simscore = vecsim_comp_record( MRO1,MRO2,0, 0, VECSIM_para);

    simscorearray = [simscorearray, simscore.score]
    
end

