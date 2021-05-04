% Tarea 4 Optimización
% 2/11/18 Minimizar la funcion con Nelder_Mead
clc
close all
% f(x1,x2)= x1^2-4x1+x2^2-x2-x1x2

% Inicia
% Se definen variables
alpha=1.0;
beta=0.5;
gama=1.5;
error=0.001;           % Error maximo permitido
x1=[1 0];              % Samplex inicial
x2=[0 0.25];
x3=[0 0];

%Se grafica para visualizar el problema
[y1,y2] = meshgrid(-1:0.01:4,-0.5:0.01:3);        % Espacio 2D
Z=(y1.^2)-(4.*y1)+(y2.^2)-y2-(y1.*y2);        % Funcion multivariable
figure(1)
contour(y1,y2,Z,'ShowText','on');
title('f=x1^2-4x1+x2^2-x2-x1x2');
grid on
hold on
xlabel('X1')
ylabel('X2')
n=2;                     % Dimensiones
ok=0;                    % Indica que termine o no termine el programa

% Simplex inicial
line([x1(1), x2(1), x3(1), x1(1)], [x1(2), x2(2), x3(2), x1(2)]); % une las coordenadas con lineas.
plot(x1(1),x1(2),'o','MarkerSize',4,'MarkerEdgeColor','r','MarkerFaceColor','k');
plot(x2(1),x2(2),'o','MarkerSize',4,'MarkerEdgeColor','r','MarkerFaceColor','k');
plot(x3(1),x3(2),'o','MarkerSize',4,'MarkerEdgeColor','r','MarkerFaceColor','k');

while (ok==0)
    pause
    % Se evalua la funcion f(x) para los 3 puntos del samplex inicial
    y1(1)=x1(1);
    y2(1)=x1(2);
    fx1=y1(1)^2-4*y1(1)+y2(1).^2-y2(1)-y1(1)*y2(1); % f(x1)
    y1(2)=x2(1);
    y2(2)=x2(2);
    fx2=y1(2)^2-4*y1(2)+y2(2).^2-y2(2)-y1(2)*y2(2); % f(x2)
    y1(3)=x3(1);
    y2(3)=x3(2);
    fx3=y1(3)^2-4*y1(3)+y2(3).^2-y2(3)-y1(3)*y2(3); % f(x3)
    
    fxi=[fx1 fx2 fx3];
    % Se toman el valor mas chico para xl y el mas grande para xh
    fxh=max(fxi);  
    fxl=min(fxi);
    
    % Se toma el par x1 2 o 3 para xh y xl segun corresponda
    
    if fxh==fxi(1)          % Si se cumple es el primer elemento y se toma xh=xl
        xh=x1;
        i=1;
                            % Ahora se busca xl entre los otros 2
        if fxl==fxi(2)      % Si se cumple se toma x2
            xl=x2;
        else                % Si no se cumple es el que queda, se toma x3
            xl=x3;
        end
    else                    % Si no se cumple se busca en x2
        if fxh==fxi(2)      % Si se cumple es el segundo elemento, se toma x2
            xh=x2;
            i=2;
                            % Ahora se busca xl entre los 2 que quedan
            if fxl==fxi(1)  % Si se cumple es el primero, se toma x1
                xl=x1;
            else            % Si no se cumple es el que queda, se toma x3
                xl=x3;
            end
        else                % Si no se cumple es el que queda, se toma x3
            xh=x3;
            i=3;
                            % Ahora se busca xl entre los 2 que quedan
            if fxl==fxi(1)  % Si se cumple es el primero, se toma x1
                xl=x1;
            else            % Si no se cumple es el que queda, se toma x2
                xl=x2;
            end
        end
    end
    
    % Se revisa si se puede hacer una contraccion o expancion
    % Primero se calcula centroide x0
    xi=[0 0];
    for k=1:3 %se suman x1 x2 y x3 segun corresponda
        if (k==1)&&(k~=i)
            xi=xi+x1;
        end
        if (k==2)&&(k~=i)
            xi=xi+x2;
        end
        if (k==3)&&(k~=i)
            xi=xi+x3;
        end
    end
    x0=(1/n)*(xi); % centroide
    
    % Se calcula xr , se hace reflexion
    xr=(1+alpha)*x0-alpha*xh;
    
    %se evalua f(x0) y f(xr) para comparar  despues con f(xr) y f(xh)
    fx0=x0(1)^2-4*x0(1)+x0(2).^2-x0(2)-x0(1)*x0(2);     % f(x0)
    fxr=xr(1)^2-4*xr(1)+xr(2).^2-xr(2)-xr(1)*xr(2);     % f(xr)
    
    % Se revisa si conviene o no tomar xr o xe.
    if fxl>fxr % es mejor que el mejor, se hace expancion para ver si es todavia mejor
        % Se hace expancion xe
        xe=gama*xr+(1-gama)*x0;
        fxe=xe(1)^2-4*xe(1)+xe(2).^2-xe(2)-xe(1)*xe(2);     % f(xe)
        % Se revisa si la expancion fue exitosa
        if fxe<fxl % Si se cumple se toma xe para sustituir al peor punto
            % El peor punto xh ya se habia encontrado en i
            if i==1
                x1=xe;
            end
            if i==2
                x2=xe;
            end
            if i==3
                x3=xe;
            end
        else % si no se cumple no conviene expancion se toma xr
            % El peor punto xh ya se habia encontrado en i
            if i==1
                x1=xr;
            end
            if i==2
                x2=xr;
            end
            if i==3
                x3=xr;
            end
        end
    else % si no mejora al mejor, entonces revisa si es mejor que el peor
        if fxh>fxr % si se cumple, se toma xr
            % El peor punto xh ya se habia encontrado en i
            if i==1
                x1=xr;
            end
            if i==2
                x2=xr;
            end
            if i==3
                x3=xr;
            end
        else % si no mejora al peor se hace contraccion
            xc=beta*xh+(1-beta)*x0;
            fxc=xc(1)^2-4*xc(1)+xc(2).^2-xc(2)-xc(1)*xc(2);     % f(xc)
            if fxc<min([fxh fxr]) % mejora al reflejado o al peor
                % xh se reemplaza por xc, ya se habia encontrado en i
                if i==1
                    x1=xc;
                end
                if i==2
                    x2=xc;
                end
                if i==3
                    x3=xc;
                end
            else % Si no mejora a ninguno, se reemplazan todos los puntos
                 % del simplex por uno de menor tamaño
                 x1=(x1+xl)/2;
                 x2=(x2+xl)/2;
                 x3=(x3+xl)/2;
            end
        end
    end
    
    % Se revisa si es necesaria otra iteracion
    Q=(fx1-fx0)^2+(fx2-fx0)^2+(fx3-fx0)^2; % Se calcula el error
    Q=sqrt(Q/(n+1));    
    if Q<=error % Si cumple el error se termina el programa
        % Se despliegan resultados
        disp('Punto optimo x* es:')
        x0
        ok=1;
        plot(x0(1),x0(2),'o','MarkerSize',4,'MarkerEdgeColor','k','MarkerFaceColor','r');
    else
        % Se grafican el nuevo simplex
        line([x1(1), x2(1), x3(1), x1(1)], [x1(2), x2(2), x3(2), x1(2)]); % une las coordenadas con lineas.
        plot(x1(1),x1(2),'o','MarkerSize',4,'MarkerEdgeColor','r','MarkerFaceColor','k');
        plot(x2(1),x2(2),'o','MarkerSize',4,'MarkerEdgeColor','r','MarkerFaceColor','k');
        plot(x3(1),x3(2),'o','MarkerSize',4,'MarkerEdgeColor','r','MarkerFaceColor','k');
    end
end 
