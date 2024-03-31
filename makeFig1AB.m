function X=makeFig1AB

load Lp %Lead-only proportion delivered simulation data
load Lt %Lead-only time to completion simulation data
load Mp %Mixed proportion delivered simulation data
load Mt %Mixed time to completion simulation data
load Sp %Herd-only proportion delivered simulation data
load St %Herd-only time to completion simulation data 

p=0:0.1:1;

subplot(2,1,1)
%PLOT LEAD
R=Lt;
Y=R(:,:); 
YY=mean(R(:,:)); %Mean
E=std(Y).*ones(1,size(R,2)); %Std dev
errorbar(p,YY,E,'.-r','LineWidth',2); %Plot mean and std dev.
%ylim([0 1])
title('A')
ylabel('Time to completion')
xlabel('Proportion followers (p)')

hold on

%PLOT MIXED
R=Mt;
Y=R(:,:); 
YY=mean(R(:,:)); %Mean
E=std(Y).*ones(1,size(R,2)); %Std dev
errorbar(p,YY,E,'.-g','LineWidth',2); %Plot mean and std dev.
%ylim([0 1])

hold on

%PLOT HERD
R=St;
Y=R(:,:); 
YY=mean(R(:,:)); %Mean
E=std(Y).*ones(1,size(R,2)); %Std dev
errorbar(p,YY,E,'.-b','LineWidth',2); %Plot mean and std dev.
%ylim([0 1])

subplot(2,1,2)

%PLOT LEAD
R=Lp;
Y=R(:,:); 
YY=mean(R(:,:)); %Mean
E=std(Y).*ones(1,size(R,2)); %Std dev
errorbar(p,YY,E,'.-r','LineWidth',2); %Plot mean and std dev.
%ylim([0 1])
title('B')
ylabel('Proportion delivered to target')
xlabel('Proportion followers (p)')

hold on

%PLOT MIXED
R=Mp;
Y=R(:,:); 
YY=mean(R(:,:)); %Mean
E=std(Y).*ones(1,size(R,2)); %Std dev
errorbar(p,YY,E,'.-g','LineWidth',2); %Plot mean and std dev.
%ylim([0 1])

hold on

%PLOT HERD
R=Sp;
Y=R(:,:); 
YY=mean(R(:,:)); %Mean
E=std(Y).*ones(1,size(R,2)); %Std dev
errorbar(p,YY,E,'.-b','LineWidth',2); %Plot mean and std dev.
%ylim([0 1])