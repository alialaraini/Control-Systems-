%lead compensator, frequency response
K_FR = 3.5 ; %gain chosen to move crossover frequency to the right
beta = 0.2675 ; %computed values (please use 4 decimal places)
T = 0.0487 ;

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


%bonus #2, your overall impressions of the design process


