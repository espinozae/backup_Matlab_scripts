%clear all
close all
clc


syms theta1 x1 theta1p x1p theta2 x2 theta2p x2p  w p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 gamma y1 y2 y3 y4 y5 y6 y7 y8 alpha1 alpha2 alpha3 alpha4 alpha5 alpha6 alpha7 alpha8 r a  t phi b k alpha u v r1 r2 eta kk c

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

% para sacar jaco se comenta
% alpha1=a*r/2;
% alpha2=a*r/2;
% alpha3=r/2;
% alpha4=r/2;
% alpha5=a*r/2;
% alpha6=a*r/2;
% alpha7=r/2;
% alpha8=r/2;


n1=1;
n2=-1;
n3=1;
n4=-1;
n5=1;
n6=-1;
n7=1;
n8=-1;

Q1=simplify(alpha8*n8*P1-alpha1*n1*P8);
Q2=simplify(alpha8*n8*P2-alpha2*n2*P8);
Q3=simplify(alpha8*n8*P3-alpha3*n3*P8);
Q4=simplify(alpha8*n8*P4-alpha4*n4*P8);
Q5=simplify(alpha8*n8*P5-alpha5*n5*P8);
Q6=simplify(alpha8*n8*P6-alpha6*n6*P8);
Q7=simplify(alpha8*n8*P7-alpha7*n7*P8);

Q =simplify(subs([Q1;Q2;Q3;Q4;Q5;Q6;Q7]))


x=[alpha1;alpha2;alpha3;alpha4;alpha5;alpha6;alpha7];

jq1=jacobian(Q1,x);
jq2=jacobian(Q2,x);
jq3=jacobian(Q3,x);
jq4=jacobian(Q4,x);
jq5=jacobian(Q5,x);
jq6=jacobian(Q6,x);
jq7=jacobian(Q7,x);

matri=[jq1;jq2;jq3;jq4;jq5;jq6;jq7] 

syms lambdo sigma r

delto=alpha8*lambdo*eye(7,7); %variabl de la que se saca raiz

matri=matri+delto 
    
%amplitud "r"    
r=sqrt((w^2*(4*p10 + 4*a*p9 - 4*gamma*p11))/((-p11*(3*w^2 + 1))));

%se definen amplitudes propuestas para obtener solucion deseada en vector
%de estados de salida
alpha1=a*r/2;
alpha2=a*r/2;
alpha3=r/2;
alpha4=r/2;
alpha5=a*r/2;
alpha6=a*r/2;
alpha7=r/2;
alpha8=r/2;

p6=p4*p11/p9
p5=p6*p10/p11
p4=p9*p12/p13

a11=p7;
a12=(p8-p2+2*k*p13);
a13=-p3-2*k*p12;

%amplitud "a" para pendulo
a=(-a12-sqrt(a12^2-4*a11*a13))/(2*a11);

matre=subs(matri);

%%parametros usados
m1=1.785;
m2=0.213;
g=9.81;
l1=0.33;
lc1=-0.0376;
I2I1=0.0246;

deltax=1/(m1*lc1^2-I2I1);
aa=m1*lc1*g*deltax;
b=-m2*g*deltax;
kappa=(m1*lc1^2+l1*m1*lc1-I2I1)*deltax;

c=kappa*g;
d=-l1*m2*g*deltax;
deltau=1/(I2I1-m1*lc1^2);
e=l1*deltau;
f=l1^2*deltau+1/m2;

k=0.2; % ok in phase y anti phase

k1=2.2409;
k2=2.1235;
k3=0.1854;
k4=1.5353;


lambda=5.6; % ok anti phase y in phase 
% gamma=.1225; 
gamma=0.2025;
w=sqrt(aa);
mu=.35;

p2=k1*e/mu;
p3=(k2*e+b)/mu;
p4=k3*e/mu;
p5=k4*e/mu;
p6=e*lambda/mu;
p7=(c-k1*f)/mu;
p8=(-k2*f-d+aa)/mu;
p9=-k3*f/mu;
p10=-k4*f/mu;
p11=-f*lambda/mu;
p12=-e/mu;
p13=f/mu;

mf=subs(matre);

polinomio=vpa(det(subs(mf)),2)

%%%  Sacar las raices del polinomio caracter�stico  y tienen que tener
%%%  parte real negativa para que la soluci�n s�ncrona sea estable.

%%% para sacar las ra�ces, primero obtenemos los coeficientes del polinomio caracter�stico y para esto usamos el commando "coeffs"

coeficientes=coeffs(polinomio)

%%%este comando nos arroja los coefficientes del polinomio ordenados de
%%%menor a mayor y hay que "re-arreglarlos" en el sentido contrario, es
%%%decir de mayor a menor

coeficientes_ordenados= [coeficientes(8) coeficientes(7) coeficientes(6) coeficientes(5) coeficientes(4) coeficientes(3) coeficientes(2) coeficientes(1)]
    
%%Finalmente, obtenemos las ra�ces, usando el comando "roots"

raices=roots(coeficientes_ordenados)
