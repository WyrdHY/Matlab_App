myScope = oscilloscope();
availableResources = resources(myScope);
myScope.Resource = 'USB0::0x2A8D::0x0396::CN61297440::0::INSTR';
connect(myScope);

[i,j,k] = readWaveform(myScope); % channel 2, 3, 4 are recorded

subplot(3, 1, 1); 
plot(i);
xlabel('Samples');
ylabel('Voltage');
title('Channel i');

subplot(3, 1, 2); 
plot(j);
xlabel('Samples');
ylabel('Voltage');
title('Channel j');

subplot(3, 1, 3); 
plot(k);
xlabel('Samples');
ylabel('Voltage');
title('Channel k');

baseFolder = 'C:\\Users\\Dirk\\Documents\\oscilloscope_Measurement';

dateFolder = datestr(now, 'mm-dd-yyyy');

fullPath = fullfile(baseFolder, dateFolder);

if ~exist(fullPath, 'dir')
    mkdir(fullPath);
end

timestamp = datestr(now, 'yyyymmdd_HHMMSS');

filenamei = sprintf('%s\\chi_%s.mat', fullPath, timestamp);
filenamej = sprintf('%s\\chj_%s.mat', fullPath, timestamp);
filenamek = sprintf('%s\\chk_%s.mat', fullPath, timestamp);

save(filenamei, 'i');
save(filenamej, 'j');
save(filenamek, 'k');
