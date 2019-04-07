function output = runep(idffilepath, epwfilename)
%RUN_ENERGYPLUS Run EnergyPlus process from Matlab.
%
%   output = runep(idf, epw):

ENERGYPLUS_PATH = getenv('ENERGYPLUS');
INPUT_FILE = [ENERGYPLUS_PATH, 'IO\Input\building.idf'];
OUTPUT_FILE = [ENERGYPLUS_PATH, 'IO\Output\building.csv'];
BAT = [ENERGYPLUS_PATH, 'RunEPlus.bat'];


[dir, idffilename, ext] = fileparts(idffilepath);
copyfile(idffilepath, INPUT_FILE);
dos([BAT, ' building ', epwfilename]);
output = csvread(OUTPUT_FILE, 1, 1);
DateTime = importdatetime(OUTPUT_FILE);
output = [DateTime, output];
delete('eplusout.csv');
delete('eplusout.end');
end

function DateTime = importdatetime(filename, startRow, endRow)

%% Initialize variables.
delimiter = ',';
if nargin<=2
    startRow = 1;
    endRow = inf;
end

%% Read columns of data as strings:
formatSpec = '%s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'HeaderLines', startRow(1)-1, 'ReturnOnError', false);
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'HeaderLines', startRow(block)-1, 'ReturnOnError', false);
    dataArray{1} = [dataArray{1};dataArrayBlock{1}];
end

%% Close the text file.
fclose(fileID);

%% Convert the contents of columns containing numeric strings to numbers.
% Replace non-numeric strings with NaN.
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = dataArray{col};
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));

% Convert the contents of column with dates to serial date numbers using
% date format string (datenum).
for row=1:length(dataArray{1})
    try
        numericData(row, 1) = datenum(dataArray{1}{row}, 'mm/dd HH:MM:SS');
        raw{row, 1} = numericData(row, 1);
    catch me
    end
end


%% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells

%% Allocate imported array to column variable names
DateTime = cell2mat(raw(:, 1));
DateTime = DateTime(2 : length(DateTime));
end

