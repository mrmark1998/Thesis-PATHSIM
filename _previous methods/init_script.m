load PCI_ID;
 
FIELD_NUM = 13;
FD_idx_ID = 1;
FD_idx_SECT = 2;
FD_idx_TS = 3;
FD_idx_PCI = 4;
FD_idx_RSRP = 5;
FD_idx_RSRQ = 6;
FD_idx_Tadv = 7;
FD_idx_PHR = 8;
FD_idx_UpSINR = 9;
FD_idx_SceEuTxRxTD = 10;
FD_idx_nPCI = 11;
FD_idx_nRSRP = 12;
FD_idx_nRSRQ = 13;
FD_idx_locx = FD_idx_nRSRQ+1;
FD_idx_locy = FD_idx_nRSRQ+2;
FD_idx_locz = FD_idx_nRSRQ+3;
FD_idx_AoA = FD_idx_PHR; % NOTE: abuse this field for now

VECSIM_para.FD_idx_ID = FD_idx_ID;
VECSIM_para.FD_idx_SECT = FD_idx_SECT;
VECSIM_para.FD_idx_TS = FD_idx_TS;
VECSIM_para.FD_idx_PCI = FD_idx_PCI;
VECSIM_para.FD_idx_RSRP = FD_idx_RSRP;
VECSIM_para.FD_idx_RSRQ = FD_idx_RSRQ;
VECSIM_para.FD_idx_Tadv = FD_idx_Tadv;
VECSIM_para.FD_idx_PHR = FD_idx_PHR;
VECSIM_para.FD_idx_UpSINR = FD_idx_UpSINR;
VECSIM_para.FD_idx_SceEuTxRxTD = FD_idx_SceEuTxRxTD;
VECSIM_para.FD_idx_nPCI = FD_idx_nPCI;
VECSIM_para.FD_idx_nRSRP = FD_idx_nRSRP;
VECSIM_para.FD_idx_nRSRQ = FD_idx_nRSRQ;
VECSIM_para.FD_idx_locx = FD_idx_locx;
VECSIM_para.FD_idx_locy = FD_idx_locy;
VECSIM_para.FD_idx_locz = FD_idx_locz;
VECSIM_para.FD_idx_AoA = FD_idx_AoA;

load simpdf.mat
VECSIM_para.simpdf = simpdf;
x = 0:100;
paras = [1,10;1,5;2,5;3,4;4,4;6,4;6,3;7,3];
distp = zeros(size(paras,1), length(x));
for h=1:size(paras,1)
    distp(h,:) = gampdf(x,paras(h,1),paras(h,2));
end
VECSIM_para.gammadist = distp; 

x = 0:101;
paras = zeros(8,2); paras(:,1) = [2:8,10]'; paras(:,2) = 4;
touselen = 101;
distp = zeros(size(paras,1), touselen);
for h=1:size(paras,1)
    tempp = gampdf(x,paras(h,1),paras(h,2));
    distp(h,:) = tempp(end-touselen+1:end);
end
VECSIM_para.gammadist_rsrp = distp;