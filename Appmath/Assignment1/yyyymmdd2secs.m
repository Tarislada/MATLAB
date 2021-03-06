% yyyymmdd2secs: converts a birthdate of the form "YYYYMMDD" into the
% number of seconds that this person has been alive until now
% 
% INPUT: bdaynum - YYYYMMDD of birthdate in string
% 
% OUTPUT: lifesecs - seconds that person has been alive until now
% 
% authors: Ko, Gill, and Shin
% created: 2019/03/19
% modified: 2019/03/21

function lifesecs = yyyymmdd2secs(bdaynum)
%% Ceconfigure data
bdaynum = num2str(bdaynum);           %/ turn numbers into string so they can be seperated easily
byear = str2double(bdaynum(1:4));  %/ birth year data
bmonth = str2double(bdaynum(5:6)); %/ birth month data
bdate = str2double(bdaynum(7:8));  %/ birth date data
% Seperating year/month/date data out of the given date

%% Preset values to work with
currenttime = clock;
% Get current time
dayarray = [31 28 31 30 31 30 31 31 30 31 30 31 31 28 31 30 31 30 31 31 30 31 30 31];
% Array of days in month x2 - to avoid looping back to the beginning of the
% array or getting a negative value
year = currenttime(1)-1;
yearcount = (year-byear)*365;
month = currenttime(2);
monthcount = sum(dayarray(bmonth+1:11+month));
day = currenttime(3)-1;
% shorthand for the used values
sec = currenttime(4:6) * [3600; 60; 1];
% Translate hours/minutes/seconds into seconds

%% Calculate seconds lived
lifesecs = ((yearcount)+...                  %/ year calculation. ex) 2018-1993
    (monthcount)+...                         %/ month calculation. ex) 14-5
    (dayarray(bmonth)-bdate+1)+(day))*86400+ ...    %/ day calculation. from starting date of the target month to the last day of that month + from 1st of this month to today-1
    sec;                                            %/ seconds that were processed earlier

% ex) 2019.03.19 = 2018.14.49 - so you don't get negative values when subtracting 
  
return