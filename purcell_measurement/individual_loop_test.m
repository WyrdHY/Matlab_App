
for i = 1:30
normalizer = 0;
filename = sprintf('C:\\Users\\Dirk\\Desktop\\purcell\\05142024\\firstfuck_noYB%d.mat', i);
data = load(filename);
t = data.data.Time;
gate = data.data.Dev1_ai0;
cts = data.data.Dev1_ctr2 ;
real_flag=flagfinder(gate);
real_decay = generator(real_flag,cts);
normalizer = length(real_flag);
%plot the sum of the test_decay
rr = sum(real_decay);
dt = 8e-6;%s
figure
scatter((1:length(rr))*dt,rr,0.8)
ylim([0 200])
title(sprintf('%dth, sample size: %d', i, normalizer));
% Check if the directory exists, and if not, create it
folder = 'C:\Users\Dirk\Desktop\purcell\05142024\individualpic';
% Now save the figure
filename = sprintf('%sindividual_noYb_%d.fig', folder, i);
savefig(gcf, filename);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function result = flagfinder(target)
    %%%
    % input: trigger signal
    % output: array of index when the gate is on
    %for each round, 
    %this is how we tell the beginning of each round
    %%%
    flagfrinder = diff(target);
    result = find(flagfrinder>3) + 1;
end


%-780,+7319
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
