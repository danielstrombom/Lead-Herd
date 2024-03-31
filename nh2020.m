function CMAL=nh2020(i,P,NN,Dog,Rsheep,Rdog)

%P=Position matrix
%Dog=Dog coordinates
%Rr=repulsion radius for other sheep (size)
%Rh=repulsion radius for dog
%New optimized neighborhood-function

Rsheep=2*Rsheep;

N=size(P,1);
AG=zeros(N,3);
count=0;
VV=[0,0];

%Repulsion vector for dog
ddog=sqrt((P(i,1)-Dog(1,1))^2+(P(i,2)-Dog(1,2))^2); %distance from dog
if ddog<Rdog %If dog within Rdog
    VRdog=(1/ddog)*[(P(i,1)-Dog(1,1)),(P(i,2)-Dog(1,2))]; %Unit vector from dog to sheep i
else
    VRdog=[0,0];
end

for j=1:size(P,1)
    if j~=i
        if (P(i,1)-P(j,1))^2+(P(i,2)-P(j,2))^2<Rsheep^2 %If sheep j within dist Rsheep from sheep i
            count=count+1;
            AG(count,:)=[P(j,1),P(j,2),P(j,3)];
        end
    end
end

 
if N>1 %if more than 1 particle left so attraction
    %Topological attraction
    DIST=[sqrt((P(:,1)-P(i,1)*ones(N,1)).^2+(P(:,2)-P(i,2)*ones(N,1)).^2),[1:N]'];
    SDIST=sortrows(DIST);
    ATT=SDIST(2:NN+1,2);
    for j=1:NN
        AT(j,:)=[P(ATT(j,1),1),P(ATT(j,1),2)];
    end

    CM=(1/NN)*[sum(AT(:,1)),sum(AT(:,2))]-[P(i,1),P(i,2)];
    CMN=(1/sqrt(CM(1,1)^2+CM(1,2)^2))*CM;

else %If only 1 left no attraction
    CMN=[0,0];
end

if P(i,6)==0 %&& ddog<Rdog
    CMN=[0,0];
end

AG=AG(1:count,:);
sAG=size(AG,1);

if sAG>0 
    for j=1:sAG %For each neighbour
        V=[P(i,1)-AG(j,1),P(i,2)-AG(j,2)];
        d=sqrt(V(1,1)^2+V(1,2)^2);
        VN=(1/d^2)*V; %Relative strength is inversly proportional to distance.
        VV=VV+VN; %Add upp all repulsion vectors
    end
    VRsheep=(1/sqrt(VV(1,1)^2+VV(1,2)^2))*VV;
else
    VRsheep=[0,0]; %if no neighbour no new direction.
end

CMAL=[VRsheep;VRdog;CMN;ddog,sAG];
