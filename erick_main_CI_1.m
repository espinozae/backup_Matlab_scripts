clear all
close all
% clc

% tic
% ssize = get(0,'ScreenSize');                                                % SCREEN SIZE
% psize = [ssize(3)*0.35 ssize(4)*0.3];                                      % PLOT SIZE

fig2 = figure;
set(fig2, 'Color', 'white')                                                               % SET WHITE BACKGROUND FOR FIGURE
set(fig2,'Position',[(ssize(3) - psize(1))/2 (ssize(4) - psize(2))/2 psize(1) psize(2)])  % SET FIGURE SIZE TO 3/4 OF SCREEN AND CENTER

%results = struct('time',{},'states',{},'errors',{},'sync',{});             % CREATE STRUCTURE FOR RESULTS
sync_mat = [;];                                                             % CREATE MATRIX FOR PLOTTING RESULTS

%%% SIMULATION PARAMETERS%%%
% lambda = 4.3:0.2:5.7;
% lambda = 4.5:0.01:5.8;
% k = 0.02:0.2:1.25;
% k = 0:0.01:1.2;
CI1 = [-0.1:0.002:0.1];
CI2 = [-0.1:0.002:0.1];


for jj = 1:length(CI1)                                                % LAB
                                                  
    CI1_sim = CI1(jj);                                                % LAB                                                 
    
    for ii = 1:length(CI2)
        CI2_sim = CI2(ii);     
        
        sim('p_inv_sub_coupled_CI_1')                                        % RUN SIMULATION
        
        t = X(:,1);                                                         % READ TIME
        X1 = X(:,2);                                                        % READ STATE OF SYST 1
        X2 = X(:,3);                                                        % READ STATE OF SYST 2   
        
        e_aph = x_diff(:,2);                                                % READ ANTI-PHASE ERROR
        e_ph = x_diff_a(:,2);                                               % READ PHASE ERROR
        
        Aaph = e_aph(length(e_aph) - 10000:length(e_aph),1);
        Aph = e_ph(length(e_aph) - 10000:length(e_aph),1);
        Ax1 = X1(length(X1) - 10000:length(X1),1);
        Ax2 = X2(length(X1) - 10000:length(X2),1);
        
        flag1 = mean(abs(Aaph));
        flag2 = mean(abs(Aph));
        flag3 = mean(abs(Ax1));
        flag4 = mean(abs(Ax2));
        
        if flag3 <= 0.00009;
            sync_mat(ii,jj) = 1;
            sync_string = 'Dead'; 
            
        elseif flag1 <= 0.007                               % CHECK ANTI-PHASE SYNC
            sync_mat(ii,jj) = 2;
            sync_string = 'Anti-phase';
        
        elseif flag2 <= 0.009,                              % CHECK PHASE SYNC
            sync_mat(ii,jj) = 3;
            sync_string = 'Phase';
        
        else                                                 % CHECK FOR OTHER RESULT
            sync_mat(ii,jj) = 0;
            sync_string = 'Unkown';
        end
        
        disp(['Grid point: ', num2str(ii), ',', num2str(jj) ', CI1: ', num2str(CI1_sim), ', CI2: ', num2str(CI2_sim), ', Type of sync: ', sync_string]);
    end
end
save erick_CI1
    figure(fig2)                                             % CONTOUR PLOT
    contourf(CI1',CI2',sync_mat')
%     colorbar
    xlabel('k');
    ylabel('\lambda');
    zlabel('Sync [1: AP, 2: P, 3: Unstable, 4: Unknown]')
%     toc
