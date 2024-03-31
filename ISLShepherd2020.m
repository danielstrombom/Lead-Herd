function [NDir,delta] = ISLShepherd2020(P,R,T,ro,SL)
rng('shuffle')

%Modified shepherding algorithm. Will herd in this timestep if SL=+1 and
%lead if SL=-1.

% INPUTS
%P=current population matrix P [x-coords,y-coords,dir angles,if interacting
%with robot (1) or not (0),index of the object]
%R=current position of the robot [x-coord,y-coord]
%T=current position of the target [x-coord,y-coord]
%ro=radius of the object
%SL=herding (+1) leading (-1)

% OUTPUT
%NDir=new (normalized) directional heading of the robot

    %P,R,T inputs
    N=size(P,1);
    G=[mean(P(:,1)),mean(P(:,2))]; %Global CM of objects

    if SL==1 %Herding mode
        %Find object furthest away from the global center of mass
        DIST=[sqrt((P(:,1)-G(1,1)*ones(N,1)).^2+(P(:,2)-G(1,2)*ones(N,1)).^2),P(:,5)];
        SDIST=sortrows(DIST);
        J=SDIST(N,2); %Index of furthest sheep

        %Find object closest to the dog
        DDIST=[sqrt((P(:,1)-R(1,1)*ones(N,1)).^2+(P(:,2)-R(1,2)*ones(N,1)).^2),P(:,5)];
        SDDIST=sortrows(DDIST);
        I=SDDIST(1,2); %Index of closest sheep

        %ROBOT DIR PART

        TG=G-T; %Vector from Target to GCM
        TR=R-T; %Vector from Target to Robot
        Fo=P(J,1:2); %Coordinates of the object furthest from the GCM
        df=DIST(J,1); %Distance from the object furthest from the GCM to the GCM
        nC=P(I,1:2); %Coordinates of the object closest to the robot
        dn=DDIST(I,1); %Distance from the object closest to the robot to the robot
        RG=R-G;
        dRG=sqrt(RG(1,1)^2+RG(1,2)^2);

         if dn<3*ro || dRG<N^(2/3)*ro %If distance from robot to nearest of object to small, robot stop
             delta=0;
            RR=R-nC; % Direction from object to robot
            Dir=(1/sqrt(RR(1,1)^2+RR(1,2)^2))*RR; %Direction straight away from object      
         elseif df>N^(2/3)*ro %If any object to far away from the GCM
            GFo=Fo-G; %[(P(J,1)-TGx),(P(J,2)-TGy)];
            GFoN=(1/sqrt(GFo(1,1)^2+GFo(1,2)^2))*GFo;
            TPc=TG+GFo+ro*GFoN;
            Dir=TPc-TR; %Aim for a position behind the furthest object
          delta=1.5;
         else %if none of the above drive collection of objects to the origin
            TGN=(1/(sqrt(TG(1,1)^2+TG(1,2)^2)))*TG;
            TPd=TG+ro*N^(1/2)*TGN; %PRIMARILY CHANGE POWER OF N TO ADJUST ROBOT/DOG DISTANCE TO FLOCK WHEN IN DRIVING PHASE, OBJECT DEPENDENT
            Dir=TPd-TR; %Aim for a position behind the flock relative to the targer
          delta=1.5;
        end
         
    elseif SL==-1 %If leader & someone follows
        Dir=T-R; %Aim towards target
        delta=0.9;%1; %lead at object speed
    elseif SL==-2 %If leader but nobody follows
        Dir=G-R; %move towards GCM of group
        delta=1.5;
    end
        
     
     NDir=(1/(sqrt(Dir(1,1)^2+Dir(1,2)^2)))*Dir; %New Direction for robot

