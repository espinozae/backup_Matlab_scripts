% Tarea 4 Optimización
% 29/10/18 Encontrar raiz por metodo de Newton-Raphson

% f=x^2/2-sen(x), e=10^-5

%Inicia
% Se definen variables

x0=0.5;                     % valor inicial de busqueda
error=10^-5;                 % Error maximo permitido
n=1;                        % primer aproximacion
ok=0;                       % 1 indica que termine el programa
figure(1)                   % Se grafica para visualizar el problema
x=0:0.001:1;
plot(x,(x.^2)/2-sin(x),'linewidth',1.5);
title('f=x^2/2-sen(x)')
xlabel('x'); ylabel('f(x)');
hold on
plot(x0,(x0.^2)/2-sin(x0),'o','MarkerSize',4,'MarkerEdgeColor','k','MarkerFaceColor','k');

xi=x0;

while (ok==0)
    pause
    % Se evalua la funcion en f' y f''
    dfdx = xi-cos(xi);      % f'(X)
    d2fdx2 = 1+sin(xi);     % f''(X)
    
    % Se obtiene la primera aproximacion xi+1
    xi=xi-(dfdx/d2fdx2);    % Newton-Rapson mejorado
    
    % Se evalua en la funcion original para x*
    plot(xi,(xi.^2)/2-sin(xi),'o','MarkerSize',4,'MarkerEdgeColor','r','MarkerFaceColor','k');

    % Se determina si cumple criterio |f'(xi+1)|< e=0.01
    e=abs(xi-cos(xi)); %|f'(xi+1)|, con xi de iteracion actual
    if e<=error
        ok=1;            % Se cumple el criterio y termina el programa
        n
        disp(strcat('Punto minimo x* es:',' ', num2str(xi)))
        plot(xi,(xi.^2)/2-sin(xi),'o','MarkerSize',4,'MarkerEdgeColor','k','MarkerFaceColor','r');
    else
        ok=0;           % No se cumple criterio, se itera de nuevo
        n=n+1;          % Siguientes 2 experimentos
    end
end
     