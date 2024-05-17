myScope = oscilloscope();
availableResources = resources(myScope);
myScope.Resource = 'USB0::0x2A8D::0x0396::CN61297440::0::INSTR';
connect(myScope);

i = readWaveform(myScope); 


plot(i);
xlabel('Samples');
ylabel('Voltage');
title('Channel 1');

disp('done')

baseFolder = 'C:\\Users\\Dirk\\Documents\\oscilloscope_Measurement';

dateFolder = datestr(now, 'mm-dd-yyyy');

fullPath = fullfile(baseFolder, dateFolder);

if ~exist(fullPath, 'dir')
    mkdir(fullPath);
end

timestamp = datestr(now, 'yyyymmdd_HHMMSS');

filename = sprintf('%s\\chi_%s2G.mat', fullPath, timestamp);

save(filename, 'i');