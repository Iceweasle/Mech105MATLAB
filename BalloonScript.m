% Hot Air Balloon Script
clear
clc
global g
% set parameters
g=9.81;
r=8.65; % balloon radius
CD=0.47; % dimensionless drag coefficient
mP=265; % mass of payload
P=101300; % atmospheric pressure
Rgas=287; % Universal gas constant for dry air
TC=100; % air temperature
rhoa=1.2; % air density
zd=200; % elevation at which mass is jettisoned
md=100; % mass jettisoned
ti=0; % initial time (s)
tf=60; % final time (s)
vi=0; % initial velocity
zi=0; % initial elevation
dt=1.6; % integration time step
 
% precomputations
d = 2 * r; Ta = TC + 273.15; Ab = pi / 4 * d ^ 2;
Vb = pi / 6 * d ^ 3; rhog = P / Rgas / Ta; mG = Vb * rhog;
FB = Vb * rhoa * g; FG = mG * g; cdp = rhoa * Ab * CD / 2;
% compute times, velocities and elevations
[t,y] = Balloon(ti,vi,zi,tf,dt,FB,FG,mG,cdp,mP,md,zd);
 
% Display results
fprintf('      t(s)     v(m/s)     z(m/s)\n');
xx=[t y];
fprintf('%10.3f %10.3f %10.3f\n',xx');
 
% Plot results
subplot(2,1,1)
plot(t,y(:,1))
title('Velocity vs. time')
xlabel('time (s)'),ylabel('velocity (m/s)')
subplot(2,1,2)
plot(t,y(:,2))
title('Elevation vs. time')
xlabel('time (s)'),ylabel('elevation (m)')