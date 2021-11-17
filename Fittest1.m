function [fitresult, gof] = Fittest1(sessionnum1, sham, shamevaly, shamevalx, ex1session, ex1, ex1evaly, ex1evalx, sessionnum2, ex2, ex2evaly, ex2evalx)
%CREATEFITS(SESSIONNUM1,SHAM,SHAMEVALY,SHAMEVALX,EX1SESSION,EX1,EX1EVALY,EX1EVALX,SESSIONNUM2,EX2,EX2EVALY,EX2EVALX)
%  Create fits.
%
%  Data for 'control' fit:
%      X Input : sessionnum1
%      Y Output: sham
%      Validation X: shamevaly
%      Validation Y: shamevalx
%  Data for 'ex1' fit:
%      X Input : ex1session
%      Y Output: ex1
%      Validation X: ex1evaly
%      Validation Y: ex1evalx
%  Data for 'ex2' fit:
%      X Input : sessionnum2
%      Y Output: ex2
%      Validation X: ex2evaly
%      Validation Y: ex2evalx
%  Output:
%      fitresult : a cell-array of fit objects representing the fits.
%      gof : structure array with goodness-of fit info.
%
%  참고 항목 FIT, CFIT, SFIT.

%  MATLAB에서 09-Aug-2021 12:29:36에 자동 생성됨

%% Initialization.

% Initialize arrays to store fits and goodness-of-fit.
fitresult = cell( 3, 1 );
gof = struct( 'sse', cell( 3, 1 ), ...
    'rsquare', [], 'dfe', [], 'adjrsquare', [], 'rmse', [] );

%% Fit: 'control'.
[xData, yData] = prepareCurveData( sessionnum1, sham );

% Set up fittype and options.
ft = fittype( 'poly7' );

% Fit model to data.
[fitresult{1}, gof(1)] = fit( xData, yData, ft, 'Normalize', 'on' );

% Compare against validation data.
[xValidation, yValidation] = prepareCurveData( shamevaly, shamevalx );
residual = yValidation - fitresult{1}( xValidation );
nNaN = nnz( isnan( residual ) );
residual(isnan( residual )) = [];
sse = norm( residual )^2;
rmse = sqrt( sse/length( residual ) );
fprintf( 'Goodness-of-validation for ''%s'' fit:\n', 'control' );
fprintf( '    SSE : %f\n', sse );
fprintf( '    RMSE : %f\n', rmse );
fprintf( '    %i points outside domain of data.\n', nNaN );

% Plot fit with data.
figure( 'Name', 'control' );
h = plot( fitresult{1}, xData, yData, 'predobs', 0.9 );
set(h,'color','black');
% Add validation data to plot.
hold on
%h(end+1) = plot( xValidation, yValidation, 'go', 'MarkerFaceColor', 'w' );
%hold off
%legend( h, 'sham vs. sessionnum1', 'control', 'Lower bounds (control)', 'Upper bounds (control)', 'shamevalx vs. shamevaly', 'Location', 'NorthEast' );
% Label axes


%% Fit: 'ex1'.
[xData, yData] = prepareCurveData( ex1session, ex1 );

% Set up fittype and options.
ft = fittype( 'poly3' );

% Fit model to data.
[fitresult{2}, gof(2)] = fit( xData, yData, ft, 'Normalize', 'on' );

% Compare against validation data.
[xValidation, yValidation] = prepareCurveData( ex1evaly, ex1evalx );
residual = yValidation - fitresult{2}( xValidation );
nNaN = nnz( isnan( residual ) );
residual(isnan( residual )) = [];
sse = norm( residual )^2;
rmse = sqrt( sse/length( residual ) );
fprintf( 'Goodness-of-validation for ''%s'' fit:\n', 'ex1' );
fprintf( '    SSE : %f\n', sse );
fprintf( '    RMSE : %f\n', rmse );
fprintf( '    %i points outside domain of data.\n', nNaN );

% Plot fit with data.
%figure( 'Name', 'ex1' );
h2 = plot( fitresult{2}, xData, yData, 'predobs', 0.9 );
set(h2,'color',[0.8500, 0.3250, 0.0980]	);
% Add validation data to plot.
%hold on
%h2(end+1) = plot( xValidation, yValidation, 'yo', 'MarkerFaceColor', 'w' );
%hold off
%legend( h2, 'ex1 vs. ex1session', 'ex1', 'Lower bounds (ex1)', 'Upper bounds (ex1)', 'ex1evalx vs. ex1evaly', 'Location', 'NorthEast' );
% Label axes


%% Fit: 'ex2'.
[xData, yData] = prepareCurveData( sessionnum2, ex2 );

% Set up fittype and options.
ft = fittype( 'poly4' );

% Fit model to data.
[fitresult{3}, gof(3)] = fit( xData, yData, ft, 'Normalize', 'on' );

% Compare against validation data.
[xValidation, yValidation] = prepareCurveData( ex2evaly, ex2evalx );
residual = yValidation - fitresult{3}( xValidation );
nNaN = nnz( isnan( residual ) );
residual(isnan( residual )) = [];
sse = norm( residual )^2;
rmse = sqrt( sse/length( residual ) );
fprintf( 'Goodness-of-validation for ''%s'' fit:\n', 'ex2' );
fprintf( '    SSE : %f\n', sse );
fprintf( '    RMSE : %f\n', rmse );
fprintf( '    %i points outside domain of data.\n', nNaN );

% Plot fit with data.
%figure( 'Name', 'ex2' );
h3 = plot( fitresult{3}, xData, yData, 'predobs', 0.9 );
set(h3,'color',[0, 0.4470, 0.7410]);
% Add validation data to plot.
%hold on
%h3(end+1) = plot( xValidation, yValidation, 'bo', 'MarkerFaceColor', 'w' );
hold off
%legend( h3, 'ex2 vs. sessionnum2', 'ex2', 'Lower bounds (ex2)', 'Upper bounds (ex2)', 'ex2evalx vs. ex2evaly', 'Location', 'NorthEast' );
%legend()
% Label axes
xlabel Sessions
ylabel Avoidance/Escape
xlim([1 18])
ylim([0 1.2])
grid off


