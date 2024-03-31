function X = ISLMaster2020aNP(pAR,L,N,NN,ro,rr,delta,t,ST)
rng('shuffle')
%Function for simulating the Lead-only, Herd-only and Mixed algorithms with
%constant agent evader/follower status.

% INPUTS
%L=side length of initial field
%N=number of objects
%NN=number of neighbours for the topological interaction
%delta=displacement of the objects per time step 
%t=number of time steps.
%pAR=0.5;%proportion of followers 
%ST=Strategy Lead (-1), Mixed (0), HERD (+1)

% OUTPUTS
% Time to completion & Proportion of agents delivered to target

N0=N; %Initial number of agents

P=zeros(N,6); % Create initial population of objects
for i=1:N % Initiate each of the N objects.
    P(i,1)=rand*L/3+2*L/3; % Initiates x-coordinate.
    P(i,2)=rand*L/3+2*L/3; % Initiates y-coordinate.
    P(i,3)=rand*2*pi-pi; % Initiates directional angle [-pi,pi].
    P(i,4)=0; %Seen robot
    P(i,5)=i; %Index of the particle
    P(i,6)=sign(rand-pAR); %Follower +, non-follower -
end
R=[1,2]; %Initial robot coordinates 
T=[0,0]; %Target coordinates

k=1;
S=0;

dST=[];
SL=1; %Start by shepherding

while S==0 && k<t % If not all agents have been delivered to target and max alloted time not reached.   
        
%     %Plotting---------------------------------------------------------
%     G=[mean(P(:,1)),mean(P(:,2))]; %Global CM of objects
%     for i=1:N
%         if P(i,6)==1
%             plot(P(i,1),P(i,2),'r.','markersize',10);
%         else
%             plot(P(i,1),P(i,2),'g.','markersize',10);
%         end
%     hold on
%     end
%     plot(R(1,1),R(1,2),'bo','markersize',10);
%    % plot(G(1,1),G(1,2),'r*','markersize',10);
%     plot(T(1,1),T(1,2),'g*','markersize',10);
%     %theta=0:0.1:2*pi;
%     %        for r=1:N
%     %             plot(P(r,1)+ro*cos(theta),P(r,2)+ro*sin(theta),'r-','markersize',1);           
%     %        end
%     hold off
%     % axis([0 L+L/2 0 L+L/2]);
%     xlabel('X position')
%     ylabel('Y position')
%     axis manual
%      axis([min(-L/2,min(P(:,1))) max(L+L/2,max(P(:,1))) min(-L/2,min(P(:,2))) max(L+L/2,max(P(:,2)))]); 
%     M(k)=getframe; %makes a movie fram from the plot
%     %-------------------------------------------------------------------     
    
    %LEAD OR SHEPHERD

  dST=[sqrt((P(:,1)-R(1,1)*ones(N,1)).^2+(P(:,2)-R(1,2)*ones(N,1)).^2)];
  sdST=size(dST,2);
  if k>1
      if ST==-1 %Lead only
          if sum(dST<1)>0 %someone is following
            SL=-1; %lead
          else %move toward the GCM of the group (New)
              SL=-2;
          end
      elseif ST==0 %Mixed
          if sum(dST<1)>0 %someone is following %Works because the fact that if repelled will be much further away
                SL=-1; %lead
            else
                SL=1; %Shepherd
          end
      elseif ST==1 %Herd only
          SL=1;
      end
          
    end
    
    [NDir,deltaS]=ISLShepherd2020(P,R,T,ro,SL); %New heading of the shepherd
    R=R+deltaS*NDir; %Move shepherd
    
    P=ISLObjects2020(P,NN,R,ro,rr,delta); %Update Position of objects
    
    dTP=[sqrt((P(:,1)-T(1,1)*ones(N,1)).^2+(P(:,2)-T(1,2)*ones(N,1)).^2)]; %Distace from all objects to target
    
    %Update pop matrix removing objects delivered to target.
    PP=[];
    for i=1:N
        if dTP(i,1)>15
            PP=[PP;P(i,:)];
        end
    end
    N=size(PP,1);
    PP(:,5)=[1:N]';
    P=PP;
    if N<NN+1 && N>1
        NN=N-1;
    end

    if N==0 %If no objects left
        X=k; %Record time to completion
        S=1; %Call to terminate sim
    end
    if mod(k,100)==0
   %     k
    end
    k=k+1;
end
    
if S==0 %If simulation did not end before t
    X=[t,(N0-N)/N0]; %record max time t & proportion delivered
else %If simulation ended before t
    X=[k,1];
end