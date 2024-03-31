function X=makeFig1C

%Function to plot performance (proportion of agents delivered and 
% proportion of max allowed time used) of the mixed algorithm with probability of 
%switching strategy per timestep ps from 0 to 0.05 in increments of 0.001 
%per timestep. 

ps=0:0.001:0.05; %Probabilities of switch in each time step
sp=size(ps,2); %The number of ps values

load Mtps
load Mpps

%PLOT
R=Mtps/6000; %Proportion of allowed max time
Y=R(:,:); %Time to completion returned from 100 simulations for each ps
YY=mean(R(:,:)); %Mean of the time to completion for each ps
E=std(Y).*ones(1,size(R,2)); %Std dev of the time to completion for each ps
errorbar(ps,YY,E,'.-b','LineWidth',2); %Plot time to completion mean and std dev.
%ylim([0 1])
%xlim([0 0.05])
title('C')
ylabel('Proportion')
xlabel('Probability of switching strategy per timestep (\pi)')

hold on
R=Mpps;
Y=R(:,:); %Polarization measurements returned from 100 simulations for each c
YY=mean(R(:,:)); %Mean of the polarization for each c
E=std(Y).*ones(1,size(R,2)); %Std dev of the polarization for each c
errorbar(ps,YY,E,'.-r','LineWidth',2); %Plot mean polarization and std dev.
ylim([0 1])



