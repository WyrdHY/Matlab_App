%%%
%This code is designed for continuous measurement
%The for loop, start


for i = 1:30
    d = daqlist("ni"); 
    deviceInfo = d{1, "DeviceInfo"};
    dq = daq("ni");
    dq.Rate = 1250000; % counting rate
    
    % Setup photon counting
    addinput(dq, "Dev1", "ai0", "Voltage"); % Analog input for voltage
    ch = addinput(dq, "Dev1", "ctr2", "EdgeCount"); % Counter for photon counting
    ch.ActiveEdge = 'Rising'; % Set the edge type
    
    % Acquire data for 60 seconds
    data = read(dq, seconds(60));
    
    % Create a unique filename for each iteration
    filename = sprintf('C:/Users/Dirk/Desktop/purcell/05142024/firstfuck_noYB%d.mat', i);

    
    % Save the data
    save(filename, 'data');
    
    disp(i)
end
