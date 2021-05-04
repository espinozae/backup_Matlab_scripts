% Tarea 3 Optimización
% 27/10/18 Encontrar raiz por metodo de Dicotomia

% f=x^3/16-27x/4 de [0,10] s=0.001, e=10^-5

% Inicia
% Se definen variables
a=0;                    % Limite inferior del intervalo de busqueda
b=10;                   % Limite superior del intervalo de busqueda
dx=0.0001;              % Distancia pequena al punto medio
error=1*10^-5;          % Error maximo permitido
L0=b-a;                 % Longitud del intervalo
xm=a+(L0/2);            % Punto medio
n=2;                    % Primeros 2 experimentos
ok=0;                   % Indica que termine o no termine el programa
figure(1)
plot(a:0.001:b,(((a:0.001:b).^3)/16)-((27*(a:0.001:b))/4));
title('f=x^3/16-27x/4')
xlabel('x'); ylabel('f(x)');
hold on
while (ok==0)
    pause
    % Se evalua la funcion en 2 puntos cercanos al punto medio
    x1=xm-(dx/2);        % f1
    x2=xm+(dx/2);        % f2

    fx1=((x1^3)/16)-((27*x1)/4);
    fx2=((x2^3)/16)-((27*x2)/4);

%     fx1=x1*(x1-1.5)
%     fx2=x2*(x2-1.5)

    % Se comparan para elegir el intervalo a descartar
    if fx1<=fx2
        b=x2;            % Nuevo intervalo [a,x2]=[a,b] para la siguiente iteracion
    else     % x1>x2
        a=x1;            % Nuevo intervalo [x1,b]=[a,b] para la siguiente iteracion
    end

    % Se actualiza el valor de las longitudes
    Ln=b-a;              % Longitud del intervalo
    xm=a+(Ln/2);         % Punto medio

    plot(a:0.001:b,(((a:0.001:b).^3)/16)-((27*(a:0.001:b))/4),'linewidth',1.5);
    hold on
    plot(xm,((xm^3)/16)-(27*xm/4),'o','MarkerSize',4,'MarkerEdgeColor','k','MarkerFaceColor','k');
    % Se calcula el error
    Ln=(L0/(2^(n/2)))+(dx*(1-(1/(2^(n/2)))));
    e=(1/2)*(Ln/L0);     % Despliega el error en esta iteración

    % Se evalua si es necesario reprtir el proceso
    if e<=error
        ok=1;            % Se cumple el criterio y termina el programa
        n
        disp(strcat('Punto minimo x* es:',' ', num2str(xm)))
        plot(xm,((xm^3)/16)-((27*xm)/4),'o','MarkerSize',4,'MarkerEdgeColor','k','MarkerFaceColor','r');
    else
        ok=0;           % No se cumple criterio, se itera de nuevo
        n=n+2;          % Siguientes 2 experimentos
    end
    pause
end
     
