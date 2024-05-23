clc;
clear all;
num = 17;
den = [1 5 0 0 0];
[A,B,C,D] = tf2ss(num,den);
G = ss(A,B,C,D);
s = tf("s");

S = 10^-2* ((s/0.01)+1) /  ((s/100)+1);
ws = S^-1;

T = 1130000 * ((s/0.1)+1) / ((s/10000)+1);
wt = T^-1;

wu = 0.00001;

p = augtf(G,ws,wt,wu);
[K , CL , GAM , INFO] = hinfsyn(p,1,1);
K_tf = tf(K);
plant = (17) / (s^4 + 5*s^3);
CL__ = (plant * K_tf) / (1 + plant * K_tf);
%bode(CL__);
[y, t] = step(CL__);
info= stepinfo(y,t);
step(CL__);
disp('info computed via h-inf:') 
info