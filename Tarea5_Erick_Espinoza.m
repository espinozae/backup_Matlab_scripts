% Tarea 5 Optimización
% 23/11/18 Minimizar la funcion con Steepest-Descent
clc
close all
% f(x1,x2) = x1-x2+2*(x1^2)+2*(x1*x2)+(x2^2) Ejemplo

% Inicia
%% Se definen variables
x0=[8 9]           % Punto inicial de busqueda
error=0.05;        % Error maximo permitido
syms x1 x2

f=(4*x1-5)^2+(x2-6)^2 % Funcion a optimizar
dfdx1=diff(f,x1,1);  %Primera derivada de f respecto a x1
dfdx2=diff(f,x2,1);  %Primera derivada de f respecto a x2

%Se grafica para visualizar el problema
[y1,y2] = meshgrid(-4:0.01:9,-5:0.01:20);   % Espacio 2D
Z=(4*y1-5).^2+(y2-6).^2;        % Funcion multivariable
figure(1)
contour(y1,y2,Z,'ShowText','on');
title('f=(4*x1-5)^2+(x2-6)^2');
grid on
hold on
xlabel('X1')
ylabel('X2')
%punto inicial
plot(x0(1),x0(2),'o','MarkerSize',4,'MarkerEdgeColor','k','MarkerFaceColor','g');

xi=x0;
gradiente_f=[dfdx1 dfdx2];
ok=0;
n=0;

while(ok~=1)
    %% Calculo de la direccion de busqueda:
    pause
    d1=double(subs(dfdx1,[x1 x2],[xi(1) xi(2)])); %Evaluacion de la
    %primera derivada de f respecto a x1 en el punto X={0,0}'
    d2=double(subs(dfdx2,[x1 x2],[xi(1) xi(2)])); %Evaluacion de la
    % primera derivada de f respecto a x2 en el punto X={0,0}'
    gradiente_f_xi=[d1 d2];
    S_i=-gradiente_f_xi;
    syms lambda
    lambda_S_i=S_i*lambda;
    xi_lambda_S_i=xi+lambda_S_i;

    %% Determinar el incremento optimo lambda_i* para la direccion S_i
    % Se hace f(x_i+x_i*s_i)
    fxi_lambda_S_i=subs(f, [x1 x2], [xi_lambda_S_i(1) xi_lambda_S_i(2)]);
    dfxi_lambda_S_i_dx=diff(fxi_lambda_S_i,lambda,1);  % Primera derivada
    
    % resolviendo para la primera derivada
    lambda_i=roots(sym2poly(dfxi_lambda_S_i_dx)) % solucion simbolica
    %% calcule x[i+1]=xi+lambda_i**Si=xi-lambda_i**grad_fxi
    x_i_1=xi+lambda_i*S_i;

    % Se evalua la funcion con estos elementos
    fx1=subs(f, [x1 x2], [xi(1) xi(2)]);
    fx2=subs(f, [x1 x2], [x_i_1(1) x_i_1(2)]);

    %% si X[i+1] es el punto optimo detenga el proceso
%     Q=abs((fx2-fx1)/(fx1+eps)); % Mas estricto
    Q=abs(x_i_1-xi);               % Mas rapido
    line([xi(1), x_i_1(1)], [xi(2), x_i_1(2)]); % traza el trayecto de la solucion.
    xi=x_i_1; % Se actualiza la solucion actual Xi+1
    
    if Q<error
        ok=1;
        xi
        plot(xi(1),xi(2),'o','MarkerSize',4,'MarkerEdgeColor','k','MarkerFaceColor','r');
    else
        plot(xi(1),xi(2),'o','MarkerSize',4,'MarkerEdgeColor','b','MarkerFaceColor','k');
    end
    n=n+1;
end