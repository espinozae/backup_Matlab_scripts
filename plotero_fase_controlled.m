% correr pruebi_controlled para obtener amplitudes
% correr simulacion en simulink para obtener vectores de datos

t = X.time;
x1 = X.signals.values(:,1);
x2 = X.signals.values(:,2);
% x3 = X.signals.values(:,3);
theta1 = theta.signals.values(:,1);
theta2 = theta.signals.values(:,2);
x_diff_a1=x_diff_a.signals.values(:,1);
x_diff1=x_diff.signals.values(:,1);

% % desplegar figura en dimensiones arbitrarias
% ssize = get(0,'ScreenSize');                % SCREEN SIZE
% psize = [ssize(3)*0.35 ssize(4)*0.35];      % PLOT SIZE
% 
% fig2 = figure;
% set(fig2, 'Color', 'white')                                                               % SET WHITE BACKGROUND FOR FIGURE
% set(fig2,'Position',[(ssize(3) - psize(1))/2 (ssize(4) - psize(2))/2 psize(1) psize(2)])  % SET FIGURE SIZE TO 3/4 OF SCREEN AND CENTER


%%% Gráfica de las amplitudes de la barra y su valor predicho por el método
%%% de poincare
% figure(1)
% plot(t,x1,t,x2)
% % plot(t,x1,t,x2,t,x3)
% uno = ones(size(t));
% cota=amplix*uno;
% hold on
% plot(t,cota,t,-cota)
% xlabel('Tiempo (s)');
% ylabel('Estado x_1 y x_2');
% title('Gráfica de estados x'); % no se va usar en articulo

%%% Gráfica de las amplitudes del péndulo y su valor predicho por el método
%%% de poincare
figure(2)
plot(t,theta1,t,theta2)
uno = ones(size(t));
cota = amplit*uno;
hold on
plot(t,cota,t,-cota)
xlabel('Time (s)');
ylabel('Amplitude \theta_1 y \theta_2 (rad)');
title('Dynamics in limit cycle');

% grafica de fases sin transitorio de sincronizacion
figure (3)
t_A=145000; % tiempo a recortar
plot(t(1:length(t)-t_A),theta1(1:length(t)-t_A))
% plot(t((length(t)-t_A):length(t)),theta1((length(t)-t_A):length(t)))
hold on
plot(t(1:length(t)-t_A),theta2(1:length(t)-t_A))


% plot(t((length(t)-t_A):length(t)),theta2((length(t)-t_A):length(t)))
% hold on
% plot(t(((length(t)-t_A)):length(t)),cota((length(t)-t_A):length(t)))
% plot(t(((length(t)-t_A)):length(t)),-cota((length(t)-t_A):length(t)))

% title('Grafica de fases con la señal de referencia');
title('Dynamics from initial conditions');
xlabel('Time (s)');
ylabel('Amplitude (rad)');


% grafica de errores
figure (4)
plot(t,x_diff_a1) % in-phase
% plot(t,x_diff1) % anti-phase
hold on
title('Synchronization error');
xlabel('Time (s)');
ylabel('Error x{1} + x{2} (m)');
