%% 
%% 
%still under construction
%Right now if this is the same as the analyzer_single
%set of data for purcell  measurement
% initialize
eric= 1;
t = data.Time;
gate = data.Dev1_ai0;
cts = data.Dev1_ctr2 ;
dt = 8e-6;%s
real_flag=flagfinder(gate);
real_decay = generator(real_flag,cts);
%plot the sum of the test_decay
%%
% plot all of them
figure;
%subplot(2,1,1)
rrange = 50000:1000000;
plot(t(rrange+500000),gate(rrange+500000));
hold on; 
placeholder = zeros(length(real_flag),1)+3;
%scatter(real_flag*8e-7,placeholder); 
ylabel('voltage'); 
%xlim([seconds(2) seconds(5)])
%{
yyaxis right;
plot(t,cts); 
ylabel('counts'); 
xlabel('time'); 
%}
title(sprintf('%dth;total cts %f',eric,cts(end, :))); 
rr = sum(real_decay);


figure;
scatter((1:length(rr))*dt,rr,0.8)
title(sprintf('%dth', eric))  % if eric is expected to be an integer
ylim([2000 3000])



function result = flagfinder(target)
    %%%
    % input: trigger signal
    % output: array of index when the gate is on
    %for each round, 
    %this is how we tell the beginning of each round
    %%%
    flagfrinder = diff(target);
    result = find(flagfrinder>2) + 1;
end
%-780,+7319real_decay
function results = generator(flag,cts)
    results = zeros(length(flag), 800); %800 is the size of my diffmatrix
    for i = 1:length(flag)%-762,+7238
        ti = flag(i)-762;
        tf = flag(i) + 7238-1;
        if tf > 75000000 || ti < 0 % Check both conditions in one line
            continue; % Skip this iteration and move to the next
        end
        matrix = reshape(cts(ti:tf), 10, []);
        temp_matrix = matrix([1,10],:);
        results(i,:) = diff(temp_matrix);
    end
end







