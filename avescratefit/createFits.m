function [fitresult, gof] = createFits1(sessionnum1, sham, shamevaly, shamevalx, ex1session, ex1, ex1evaly, ex1evalx, sessionnum2, ex2, ex2evaly, ex2evalx, Control_Date, Control, ex1_Date, Ex1, ex2_Date, Ex2)
%CREATEFITS1(SESSIONNUM1,SHAM,SHAMEVALY,SHAMEVALX,EX1SESSION,EX1,EX1EVALY,EX1EVALX,SESSIONNUM2,EX2,EX2EVALY,EX2EVALX,CONTROL_DATE,CONTROL,EX1_DATE,EX1,EX2_DATE,EX2)
%  Create fits.
%
%  Data for 'Control' fit:
%      X Input : sessionnum1
%      Y Output: sham
%      Validation X: shamevaly
%      Validation Y: shamevalx
%  Data for 'Ex1' fit:
%      X Input : ex1session
%      Y Output: ex1
%      Validation X: ex1evaly
%      Validation Y: ex1evalx
%  Data for 'Ex2' fit:
%      X Input : sessionnum2
%      Y Output: ex2
%      Validation X: ex2evaly
%      Validation Y: ex2evalx
%  Data for 'Control w/o prediction' fit:
%      X Input : Control_Date
%      Y Output: Control
%  Data for 'Ex1 w/o prediction' fit:
%      X Input : ex1_Date
%      Y Output: Ex1
%  Data for 'Ex2 w/o prediction' fit:
%      X Input : ex2_Date
%      Y Output: Ex2
%  Output:
%      fitresult : a cell-array of fit objects representing the fits.
%      gof : structure array with goodness-of fit info.
%
%  참고 항목 FIT, CFIT, SFIT.

%  MATLAB에서 08-Nov-2021 19:44:10에 자동 생성됨

%% Initialization.

% Initialize arrays to store fits and goodness-of-fit.
fitresult = cell( 6, 1 );
gof = struct( 'sse', cell( 6, 1 ), ...
    'rsquare', [], 'dfe', [], 'adjrsquare', [], 'rmse', [] );

% %% Fit: 'Control'.
% [xData, yData] = prepareCurveData( sessionnum1, sham );
% 
% % Set up fittype and options.
% ft = fittype( 'poly7' );
% 
% % Fit model to data.
% [fitresult{1}, gof(1)] = fit( xData, yData, ft, 'Normalize', 'on' );
% 
% % Compare against validation data.
% [xValidation, yValidation] = prepareCurveData( shamevaly, shamevalx );
% residual = yValidation - fitresult{1}( xValidation );
% nNaN = nnz( isnan( residual ) );
% residual(isnan( residual )) = [];
% sse = norm( residual )^2;
% rmse = sqrt( sse/length( residual ) );
% fprintf( 'Goodness-of-validation for ''%s'' fit:\n', 'Control' );
% fprintf( '    SSE : %f\n', sse );
% fprintf( '    RMSE : %f\n', rmse );
% fprintf( '    %i points outside domain of data.\n', nNaN );
% 
% % Plot fit with data.
% figure( 'Name', 'Control' );
% h = plot( fitresult{1}, xData, yData, 'predobs', 0.9 );
% % Add validation data to plot.
% hold on
% h(end+1) = plot( xValidation, yValidation, 'bo', 'MarkerFaceColor', 'w' );
% hold off
% legend( h, 'sham vs. sessionnum1', 'Control', 'Lower bounds (Control)', 'Upper bounds (Control)', 'shamevalx vs. shamevaly', 'Location', 'NorthEast' );
% % Label axes
% xlabel sessionnum1
% ylabel sham
% grid on

%% Fit: 'Ex1'.
% [xData, yData] = prepareCurveData( ex1session, ex1 );
% 
% % Set up fittype and options.
% ft = fittype( 'poly3' );
% 
% % Fit model to data.
% [fitresult{2}, gof(2)] = fit( xData, yData, ft, 'Normalize', 'on' );
% 
% % Compare against validation data.
% [xValidation, yValidation] = prepareCurveData( ex1evaly, ex1evalx );
% residual = yValidation - fitresult{2}( xValidation );
% nNaN = nnz( isnan( residual ) );
% residual(isnan( residual )) = [];
% sse = norm( residual )^2;
% rmse = sqrt( sse/length( residual ) );
% fprintf( 'Goodness-of-validation for ''%s'' fit:\n', 'Ex1' );
% fprintf( '    SSE : %f\n', sse );
% fprintf( '    RMSE : %f\n', rmse );
% fprintf( '    %i points outside domain of data.\n', nNaN );
% 
% % Plot fit with data.
% figure( 'Name', 'Ex1' );
% h = plot( fitresult{2}, xData, yData, 'predobs', 0.9 );
% % Add validation data to plot.
% hold on
% h(end+1) = plot( xValidation, yValidation, 'bo', 'MarkerFaceColor', 'w' );
% hold off
% legend( h, 'ex1 vs. ex1session', 'Ex1', 'Lower bounds (Ex1)', 'Upper bounds (Ex1)', 'ex1evalx vs. ex1evaly', 'Location', 'NorthEast' );
% % Label axes
% xlabel ex1session
% ylabel ex1
% grid on

% %% Fit: 'Ex2'.
% [xData, yData] = prepareCurveData( sessionnum2, ex2 );
% 
% % Set up fittype and options.
% ft = fittype( 'poly4' );
% 
% % Fit model to data.
% [fitresult{3}, gof(3)] = fit( xData, yData, ft, 'Normalize', 'on' );
% 
% % Compare against validation data.
% [xValidation, yValidation] = prepareCurveData( ex2evaly, ex2evalx );
% residual = yValidation - fitresult{3}( xValidation );
% nNaN = nnz( isnan( residual ) );
% residual(isnan( residual )) = [];
% sse = norm( residual )^2;
% rmse = sqrt( sse/length( residual ) );
% fprintf( 'Goodness-of-validation for ''%s'' fit:\n', 'Ex2' );
% fprintf( '    SSE : %f\n', sse );
% fprintf( '    RMSE : %f\n', rmse );
% fprintf( '    %i points outside domain of data.\n', nNaN );
% 
% % Plot fit with data.
% figure( 'Name', 'Ex2' );
% h = plot( fitresult{3}, xData, yData, 'predobs', 0.9 );
% % Add validation data to plot.
% hold on
% h(end+1) = plot( xValidation, yValidation, 'bo', 'MarkerFaceColor', 'w' );
% hold off
% legend( h, 'ex2 vs. sessionnum2', 'Ex2', 'Lower bounds (Ex2)', 'Upper bounds (Ex2)', 'ex2evalx vs. ex2evaly', 'Location', 'NorthEast' );
% % Label axes
% xlabel sessionnum2
% ylabel ex2
% grid on

%% Fit: 'Control w/o prediction'.
[xData, yData] = prepareCurveData( Control_Date, Control );

% Set up fittype and options.
ft = fittype( 'poly5' );

% Fit model to data.
[fitresult{4}, gof(4)] = fit( xData, yData, ft, 'Normalize', 'on' );

% Plot fit with data.
figure( 'Name', 'Control w/o prediction' );
plot1 = plot( fitresult{4}, xData, yData, 'predobs', 0.9 );
set(plot1,'Color','k','Linewidth',2);
hold on
% Label axes
xlabel Control_Date
ylabel Control
grid off

%% Fit: 'Ex1 w/o prediction'.
[xData, yData] = prepareCurveData( ex1_Date, Ex1 );

% Set up fittype and options.
ft = fittype( 'poly3' );

% Fit model to data.
[fitresult{5}, gof(5)] = fit( xData, yData, ft, 'Normalize', 'on' );

% Plot fit with data.
%figure( 'Name', 'Ex1 w/o prediction' );
plot2 = plot( fitresult{5}, xData, yData, 'predobs', 0.9 );
set(plot2,'Color',[233/256 139/256 103/256],'Linewidth',2);
% Label axes
xlabel ex1_Date
ylabel Ex1
grid off

%% Fit: 'Ex2 w/o prediction'.
[xData, yData] = prepareCurveData( ex2_Date, Ex2 );

% Set up fittype and options.
ft = fittype( 'poly4' );

% Fit model to data.
[fitresult{6}, gof(6)] = fit( xData, yData, ft, 'Normalize', 'on' );

% Plot fit with data.
%figure( 'Name', 'Ex2 w/o prediction' );
plot3 = plot( fitresult{6}, xData, yData, 'predobs', 0.9 );
set(plot3,'Color',[29/256 95/256 140/256],'Linewidth',2);

% Label axes
xlabel Sessions
ylabel AvoidanceRatio
grid off
xlim([1 19])
ylim([0 1.2])
yticks([0 0.2 0.4 0.6 0.8 1.0 1.2])
set(gca,'box','off')



