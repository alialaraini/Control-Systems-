%% Project report
%Ali Alaraini
%ME 432 - 002
%May 12, 2019
clear;clc;close all

%%
%----- YOU SUPPLY THESE VALUES -------------

%lead compensator, root locus
clc
CLim = ;%imaginary part of the desired CL pole, enter as a positive number
zclead = -10.05 ; 
pclead = -45.95 ; %computed pole, enter as a negative number
K_RL = 111.25 ; %gain that gives the desired CL pole

%lead compensator, frequency response
K_FR = ; %gain chosen to move crossover frequency to the right
beta = ; %computed values (please use 4 decimal places)
T = ;
%-------------------------------------------
G = zpk([],[-10.05 0],239.25); %the plant: do not change!
Tun = feedback(G,1);
%% 
% Lead compensator design: root locus
Gc_RL = zpk(zclead,pclead,K_RL/239.25) %divide by 239.25 so we can multiply to G
%
%first, show that the new root locus passes thru design CL
figure
rlocus(Gc_RL*G)
hold on
plot(CLre,CLim,'r*')
title('compensated root locus')
%
%now verify the closed-loop response
figure
T_RL=feedback(Gc_RL*G,1);
figure
step(Tun,T_RL)
legend('uncompensated','RL lead compensated','location','best')
%print out...
T_RLinfo=stepinfo(T_RL);
fprintf('overshoot goal: 20%% \tovershoot = %.2f%%\n',T_RLinfo.Overshoot)
fprintf('peak time goal: 0.1s \tpeak time = %.2f s\n',T_RLinfo.PeakTime)

%%
% Lead compensator design: frequency response
Gc_FR = zpk(-1/T,-1/(beta*T),K_FR/beta)

%Open loop compensated--check phase margin
[~,Pm_FR]=margin(Gc_FR*G);
%Closedloop compensated--check bandwidth
T_FR = feedback(Gc_FR*G,1);
wbw=bandwidth(T_FR);
%showing the closed loop response
figure
step(Tun,T_FR)
legend('uncompensated','freq resp lead compensated','location','best')
%print out...
fprintf('Pm goal: 50 degrees \tPm = %.2f degrees\n',Pm_FR)
fprintf('bandwidth goal: 45 rad/s \tbandwidth = %.2f rad/s\n',wbw)
%%
%bonus #1, %OS and Tp goals met
T_FRinfo=stepinfo(T_FR);
fprintf('overshoot goal: 20%% \tovershoot = %.2f%%\n',T_FRinfo.Overshoot)
fprintf('peak time goal: 0.1s \tpeak time = %.3f s\n',T_FRinfo.PeakTime)
%%
%bonus #2, your overall impressions of the design process


