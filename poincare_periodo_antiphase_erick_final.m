clear all
close all
clc


syms theta1 x1 theta1p x1p theta2 x2 theta2p x2p  w p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 gamma y1 y2 y3 y4 y5 y6 y7 y8 alpha1 alpha2 alpha3 alpha4 alpha5 alpha6 alpha7 alpha8 r a  t phi b k alpha u v r1 r2 eta kk c mu

A=[0 0 0 0 1 0 0 0;0 0 0 0 0 1 0 0;0 0 0 0 0 0 1 0;0 0 0 0 0 0 0 1;-w^2 0 0 0 0 0 0 0;0 -w^2 0 0 0 0 0 0;0 0 -w^2 0 0 0 0 0;0 0 0 -w^2 0 0 0 0]
[V,D] = eig(A)



 Dmod1=[D(5,:);D(1,:);D(6,:);D(2,:);D(7,:);D(3,:);D(8,:);D(4,:)];
 Dmod2=[Dmod1(:,5) Dmod1(:,1) Dmod1(:,6) Dmod1(:,2) Dmod1(:,7) Dmod1(:,3) Dmod1(:,8) Dmod1(:,4)];
 D=Dmod2
 
 Vmod1=[V(1,:);V(2,:);V(3,:);V(4,:);V(5,:);V(6,:);V(7,:);V(8,:)];
 Vmod2=[Vmod1(:,5) Vmod1(:,1) Vmod1(:,6) Vmod1(:,2) Vmod1(:,7) Vmod1(:,3) Vmod1(:,8) Vmod1(:,4)];
 V=Vmod2;
 verif=simplify(V*D*inv(V))  


forza=[0;0;0;0;p2*theta1+p3*x1+p4*theta1p+p5*x1p+p6*(x1^2+x1p^2-gamma)*x1p+p12*k*(x1+x2);p7*theta1+p8*x1+p9*theta1p+p10*x1p+p11*(x1^2+x1p^2-gamma)*x1p+p13*k*(x1+x2);p2*theta2+p3*x2+p4*theta2p+p5*x2p+p6*(x2^2+x2p^2-gamma)*x2p+p12*k*(x1+x2);p7*theta2+p8*x2+p9*theta2p+p10*x2p+p11*(x2^2+x2p^2-gamma)*x2p+p13*k*(x1+x2)]
 xi=[y1 y2 y3 y4 y5 y6 y7 y8];
% 
 exis=V*transpose(xi);
% 
 theta1=exis(1,1);
 x1=exis(2,1);
 theta2=exis(3,1);
 x2=exis(4,1);
 theta1p=exis(5,1);
 x1p=exis(6,1);
 theta2p=exis(7,1);
x2p=exis(8,1);

 % 
% 
% 
 forza1=subs(forza);
% 
y1=alpha1*exp(w*i*t); 
y2=alpha2*exp(-w*i*t); 
y3=alpha3*exp(w*i*t); 
y4=alpha4*exp(-w*i*t);
y5=alpha5*exp(w*i*t); 
y6=alpha6*exp(-w*i*t); 
y7=alpha7*exp(w*i*t); 
y8=alpha8*exp(-w*i*t);

% 
% 
forza2=simplify(subs(forza1))
 
Fxi=inv(V)*forza2
% 
P1=int((Fxi(1,1))*exp(-w*i*t),t,0,2*pi/w)
P2=int((Fxi(2,1))*exp(w*i*t),t,0,2*pi/w)
P3=int((Fxi(3,1))*exp(-w*i*t),t,0,2*pi/w)
P4=int((Fxi(4,1))*exp(w*i*t),t,0,2*pi/w);
P5=int((Fxi(5,1))*exp(-w*i*t),t,0,2*pi/w)
P6=int((Fxi(6,1))*exp(w*i*t),t,0,2*pi/w)
P7=int((Fxi(7,1))*exp(-w*i*t),t,0,2*pi/w)
P8=int((Fxi(8,1))*exp(w*i*t),t,0,2*pi/w);

% 
alpha1=a*r/2;
alpha2=a*r/2;
alpha3=r/2;
alpha4=r/2;
alpha5=-a*r/2;
alpha6=-a*r/2;
alpha7=-r/2;
alpha8=-r/2;

%%%Valor de "r" encontrado    
    
 r=sqrt((w^2*(4*p10 + 4*a*p9 - 4*gamma*p11))/((-p11*(3*w^2 + 1))));
    
 p6=p4*p11/p9
 p5=p6*p10/p11
 p4=p9*p12/p13
 

tauc=-mu*P8/(-i*w*alpha8);
tauc=subs(tauc);
tauc=subs(tauc);
tauc=simplify(tauc)
% se obtiene estimacion de error de solucion aproximada en command window
% se obtiene periodo despejando T de 2*pi/(tauc+T)