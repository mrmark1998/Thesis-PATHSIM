MRO1 = POINTMRO{500,500}.mro
MRO2 = POINTMRO{500,501}.mro
simscore = vecsim_comp_record( MRO1,MRO2,0, 0, VECSIM_para)
%this will return a struct with the score along with other debug fields. To
%only view the score use simscore.score

simscore.score

