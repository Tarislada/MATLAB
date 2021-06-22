close all;
clear all;
clc;                                                        % initialize variables, windows, and command line
pre = [151.6666667	96.66666667	153	159.3333333	259.5	240.5	357	585.5];    % # of funded project data points 1
pst = [311.75	307.25	581.75	689.75	1023.25	896.3333333	997.25	973.75];  % # of unfunded project data points 2
timepoint = [1 2 3 4 5 6 7 8 ];                              % # of time points
bar(timepoint,[pre;pst]');                     % plot data points 1&2 according to timepoints
hold on;                                                    % for future plotting, hold on
pstdegree = 5;                                            % set unfunded degree    
predegree = 1;                                              % set funded degree

%% Creating Vandermonde matrix
vandermat = fliplr(vander(timepoint));                      % the whole Vandermonde matrix
                     
%% Using Householder QR factorization for unfunded
pstvandermat = vandermat(:,1:pstdegree+1);              % Calling & cutting Vandermonde matrix
[Q,newpst] = qr(pstvandermat);                          % QR factorization
pstsol = Q'*pst';                                   % Same done to results
pstval = newpst \ pstsol;                           % Solve
pstval = fliplr(pstval');                             % Flip the endresults so they can be readily used for plotting

%% Using Householder QR factorization for funded
prevandermat = vandermat(:,1:predegree+1);                  % Calling Vandermonde matrix
[Q,newpre] = qr(prevandermat);                              % QR factorization
presol = Q'*pre';                                       % Same done to results
preval = newpre \ presol;                                 % Solve
preval = fliplr(preval');                                 % Flip the endresults so they can be readily used for plotting

%% Plotting
plot(timepoint,polyval(pstval,timepoint),'r');      % plot best fit model for unfunded projects
plot(timepoint,polyval(preval,timepoint),'b');        % plot best fit model for funded projects
plot(9,polyval(pstval,9),'ro');                      % plot 2020 estimation for unfunded projects
plot(9,polyval(preval,9),'bo');                        % plot 2020 estimation for funded projects

%% Finding best fit - Calculating Residuals and predictions
preresiduals = norm(presol(predegree+2:end));              % Residuals of funded
pstresiduals = norm(pstsol(pstdegree+2:end));        % Residuals of unfunded
truval = [523	640.6666667; 907.75	1357.5];                         % Actual funded/unfunded dataset for 2017/2018
pERR_fund = zeros(1,2);
pERR_fund(1) = (truval(1,1) - polyval(preval,9)); 
pERR_fund(2) = truval(1,2) - polyval(preval,10);            % Calculate prediction error for funded
pERR_unfund = zeros(1,2);
pERR_unfund(1) = (truval(2,1) - polyval(pstval,9)); 
pERR_unfund(2) = truval(2,2) - polyval(pstval,10);        % Calculate prediction error for unfunded
qs_pre = abs(preresiduals) + abs(sum(pERR_fund));                                            % Overall assessment of fit - funded
qs_pst = abs(pstresiduals) + abs(sum(pERR_unfund));     