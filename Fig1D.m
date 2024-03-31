function X=Fig1D

%Function for running simulations to assess the performance of the mixed 
%algorithm with probability of switching strategy per timestep ps (\pi in
%manuscript) without time limit. 

T=100; %Number of simulations for each ps (\pi) value
t=10000000; %Use 10 million ts as upper limit. (increase if needed see value hit this)

ps=0:0.1:0.5; %Probabilities of switch in each time step
sp=size(ps,2); %The number of ps values


%RUN SIMULATION
TC=zeros(T,sp); %Matrix to store the completion times for MIXED. The element in the i:th row and the j:th column
PC=zeros(T,sp); %Matrix to store the completion proportion for LEAD.

parfor k=1:T
    for j=1:sp
        X=ISLMaster2020psNP(0.5,100,46,45,1,30,1,t,0,ps(1,j)); %Run simulation with j:th p value
        TC(k,j)=X(1,1); 
    end
        [k,ps(1,j)]
end

save TC TC

makeFig1D