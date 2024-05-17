





d = daqlist("ni"); 
deviceInfo = d{1, "DeviceInfo"};
dq=daq("ni")  ;
dq.Rate = 1250000;%counting rate
%Setup photons counting
addinput(dq,"Dev1","ai0","Voltage");%CTR2 means PFI 0, which supports a BNC cable 
addinput(dq,"Dev1","ctr2","EdgeCount");%CTR2 means PFI 0, which supports a BNC cable 
ch.ActiveEdge = 'Rising';
data = read(dq,seconds(60));
name = concacentate(0512,_i)
filename = 'C:\Users\Dirk\Desktop\purcell\05122024\name.mat';
save(filename, 'data');

%filename = 'C:\Users\Dirk\Desktop\purcell\05122024\useless.mat';

% Save the 'data' variable to a .mat file
%save(filename, 'data');

%% 

xi = 1; % Start index
xf = 6250000; % End index  rought 9000 is a period
figure
subplot(3,1,1);
plot(data.Time(xi:xf),data.Dev1_ctr2(xi:xf),color='r');
xlabel('Time');
ylabel('Accumulated Counts');

subplot(3,1,2);
plot(data.Time(xi:xf), data.Dev1_ai0(xi:xf),color='g');
xlabel('Time');
ylabel('Trigger');
%{
arr = data.Dev1_ctr2(xi:xf);
differences = zeros(1, length(arr) - 1);
% bin = 8e-7s
for i = 1:length(arr)-1
    differences(i) = arr(i+1) - arr(i);
end
indices = xi+1:xf;
subplot(3,1,3)
scatter(indices, differences,color='b');
xlabel('index');
ylabel('#of photons emitted in 8e-7 time window');
%}