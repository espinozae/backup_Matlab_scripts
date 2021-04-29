
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
k1=2.2409;
k2=2.1235;
k3=0.1854;
k4=1.5353;


lambda=5.6;   % cambiar parametros de simulacion
gamma=.2025;  % gamma=0.1163;  %
w=sqrt(aa);   % restriccion inicial de analisis
mu=.35;       %
k=0.6;        %


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

a11 = p7;
a12 = (p8 - p2 + 2*k*p13);
a13 = -p3-2*k*p12;

% a11=p7;
% a12=(p8 - p2);
% a13=-p3;

% correccion de amplitud en pendulo (salen de q)
a=(-a12-sqrt(a12^2-4*a11*a13))/(2*a11)
% amplitud r 
r=sqrt((w^2*(4*p10 + 4*a*p9 - 4*gamma*p11))/((-p11*(3*w^2 + 1))))    %phase

% corrección del periodo (sale de difusive_coupling)
tauc=(mu*pi*(p8 + a*p7 + 2*k*p13))/w^3;

%Periodo Original
T=2*pi/w;

%Periodo modificado/total
% Ttotal=T+tauc;
% Ttotal=1.041;
% Ttotal=1.1090;
Ttotal=1.0748; %in-phase articulo
% Ttotal=0.9196; anti-phase articulo

%Frecuencia total
wtotal=2*pi/Ttotal

%amplitud de la barra (wcorregida no original)
amplix=r/wtotal

%amplitud del péndulo
amplit=a*r/wtotal
