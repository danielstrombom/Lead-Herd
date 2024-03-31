function X=Fig1C

%Function for running simulations to assess the performance of the mixed 
%algorithm with probability of switching strategy per timestep ps (\pi in
%manuscript) with 6000 timestep time limit. 

T=100; %Number of simulations for each ps (\pi) value
t=6000; %Maximum allowed time.

ps=0:0.001:0.05; %Probabilities of switch in each time step.
sp=size(ps,2); %The number of ps values


%RUN SIMULATION
Mtps=zeros(T,sp); %Matrix to store the completion times for MIXED. The element in the i:th row and the j:th column
Mpps=zeros(T,sp); %Matrix to store the completion proportion for LEAD.

parfor k=1:T
    for j=1:sp
     X=ISLMaster2020psNP(0.5,100,46,45,1,30,1,t,0,ps(1,j)); %Run simulation with j:th ps value
        Mtps(k,j)=X(1,1);
        Mpps(k,j)=X(1,2);    
    end
    [k,ps(1,j)]
end

save Mtps Mtps
save Mpps Mpps

makeFig1C


