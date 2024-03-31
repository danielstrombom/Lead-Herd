function X=makeFig1D

%Function to plot Fig1D 

load TC

ps=0:0.1:0.5;
plot(ps,TC,'.'); %Plot the actual measurements
hold on

%PLOT MEAN AND STD
Y=TC; 
YY=mean(Y); %Mean
E=std(Y).*ones(1,size(Y,2)); %Std dev
errorbar(ps,YY,E); %Plot mean and std dev.
title('D')
ylabel('Time to completion')
xlabel('Probability of switching strategy per timestep (\pi)')

