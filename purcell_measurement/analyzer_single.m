%% 
%This code is for analyzing a single file
%you have to manually drag the file to the WORKSPACE
% initialize
eric= 31;

t = data.Time;
gate = data.Dev1_ai0;
cts = data.Dev1_ctr2 ;

%%
% plot all of them
%{
figure;
subplot(2,1,2)
yyaxis left;
plot(t,gate);
ylabel('voltage'); 
yyaxis right;
plot(t,cts); 
ylabel('counts'); 
xlabel('time'); 
title('test'); 
%}
%{
%%
% plot part of them

xi = 1;
xf = 63000;
%(xi:xf)

figure;
yyaxis left;
scatter(t(xi:xf),gate(xi:xf));
ylabel('voltage'); 
yyaxis right;
scatter(t(xi:xf),cts(xi:xf));
ylabel('counts'); 
xlabel('time'); 
title('test'); 
%%
%try to bin each 10 of them only within one segment
test_t = t(5000:13000-1);
test_cts = cts(5000:13000-1);
%%
%for each round, this is how we treat the data
matrix = reshape(test_cts, 10, []);
temp_matrix = matrix([1,10],:);
diffmatrix = diff(temp_matrix);
figure;
scatter((1:800)*8e-6,diffmatrix)
%%
%for each round, this is how we tell the beginning of each round
test_t2 = t(1:63000);
test_a2 = gate(1:63000);
flag = find(diff(test_a2)>2) + 1;

figure;
plot(t,gate);
hold on; 
scatter(flag*8e-7,3);
%plot([5000*8e-7,13000*8e-7],[2,2])

%%
% combine the efforts for previous two parts 
% and perform action on this segment
test_t = t(xi:xf);
test_cts = cts(xi:xf);
test_gate = gate(xi:xf);

test_flag=flagfinder(test_gate);
test_decay = generator(test_flag,test_cts);



%plot the sum of the test_decay
paper = sum(test_decay);

dt = 8e-6;%s
figure
plot((1:length(paper))*dt,paper)
%}
%%
%this looks good, now let's deal with the true data

real_flag=flagfinder(gate);
real_decay = generator(real_flag,cts);



%plot the sum of the test_decay
rr = sum(real_decay);
dt = 8e-6;%s
figure
scatter((1:length(rr))*dt,rr,0.8)
ylim([0 100])
title(sprintf('%fth', eric));

% Assuming you've already created your figure and it's currently open

% Save the figure as a MATLAB Figure file (.fig)
%{
% Check if the directory exists, and if not, create it
folder = 'C:\Users\Dirk\Desktop\purcell\05132024\4th_analysis\individual_plot\';

% Now save the figure
filename = sprintf('%sfourthfuck_%d.fig', folder, eric);
savefig(gcf, filename);
%}

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







