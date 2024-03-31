function PP = ISLObjects2020(P,NN,R,ro,rr,delta)
rng('shuffle')
%Function to simulate objects attracted/repelled to/from shepherd

% INPUTS
% See SheepMaster description

% OUTPUT
% PP=Updated object population matrix P

N=size(P,1);

PP=zeros(N,6); %For simultaneous update

for i=1:N % Go through every object.

    %nh1 calculates (for each object i)
    %1. its neighborhood (i.e. finds the particles in its neighborhood.) 
    %2. the direction from it toward the center of mass of its neighborhood (CM)
    %3. the 'mean' direction of its neighbors (AL)

    CMAL=nh2020(i,P,NN,R,ro,rr); % CMAL=[dir toward CM, 'mean' dir of Neighbors]


    VRo=CMAL(1,:); %Dir of repulsion from sheep
    VRr=P(i,6)*CMAL(2,:); %Dir of repulsion from dog (+,- depending on attr or rep)
    C=CMAL(3,:); %Dir of attract.
    dR=CMAL(4,1); %Distance to dog.
    nN=CMAL(4,2); %number of nearest neighbours

    if dR<rr %If the dog close enough to sheep i
        PP(i,4)=1; %it sees it
    else
        PP(i,4)=0; %else not seen it
    end

    D=[cos(P(i,3)),sin(P(i,3))]; %Direction in the previous time step

    if PP(i,4)==1 %If reacting to the robot

        %Calculate new direction
if P(i,6)==1 %if not following
        Dir=0.5*D+2*VRo+1*VRr+1.5*C; %New direction of particle i
else %if following
        Dir=0.5*D+2*VRo+1*VRr+0*C;%1.05*C; %New direction of particle i (na attraction
end
        NormDir=(1/(Dir(1,1)^2+Dir(1,2)^2)^0.5)*Dir; %Normalized direction of particle i

        %Update position   
        PP(i,1)=P(i,1)+delta*NormDir(1,1); %New x-coordinate
        PP(i,2)=P(i,2)+delta*NormDir(1,2); %New y-coordinate

        %New directional angle
        PP(i,3)=atan2(NormDir(1,2),NormDir(1,1));

        %Preserve the index of the object
        PP(i,5)=P(i,5);
        
        %Preserve type of object
        PP(i,6)=P(i,6);

    else %if not reacting to the robot, do nothing  

            PP(i,:)=P(i,:);
    end
end
        
     

