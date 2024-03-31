function X=Fig1AB

%Function to determine time to completion for p in [0,1] for all 3
%algorithms. %For each p from 0 to 1 in increments of 0.1 run T simulation, each of max
%length t, and record time to completion.

T=1000; %Number of simulations for each p value
t=6000; %Max simulation time

p=0:0.1:1; %The p values (proportion of evaders)
sp=size(p,2); %The number of p values

%LEAD ONLY 
ST=-1;

Lt=zeros(T,sp); %Matrix to store the completion times for LEAD. 
Lp=zeros(T,sp); %Matrix to store the completion proportion for LEAD.

parfor k=1:T
    for j=1:sp
        X=ISLMaster2020aNP(p(1,j),100,46,45,1,30,1,t,ST); %Run simulation with j:th p value
        Lt(k,j)=X(1,1);
        Lp(k,j)=X(1,2);
    end
    [k,-1]
end

save Lt Lt
save Lp Lp

%MIXED
ST=0;

Mt=zeros(T,sp); %Matrix to store the completion times for MIXED. The element in the i:th row and the j:th column
Mp=zeros(T,sp); %Matrix to store the completion proportion for LEAD.

parfor k=1:T
    for j=1:sp
     X=ISLMaster2020aNP(p(1,j),100,46,45,1,30,1,t,ST); %Run simulation with j:th p value
        Mt(k,j)=X(1,1);
        Mp(k,j)=X(1,2);    
    end
    [k,0]
end

save Mt Mt
save Mp Mp

%SHEPHERD ONLY
ST=1;

St=zeros(T,sp); %Matrix to store the completion times for MIXED. The element in the i:th row and the j:th column
Sp=zeros(T,sp); %Matrix to store the completion proportion for LEAD.

parfor k=1:T
    for j=1:sp
     X=ISLMaster2020aNP(p(1,j),100,46,45,1,30,1,t,ST); %Run simulation with j:th p value
        St(k,j)=X(1,1);
        Sp(k,j)=X(1,2);    
    end
    [k,1]
end

save St St
save Sp Sp

makeFig1AB
