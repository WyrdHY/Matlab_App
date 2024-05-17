%%
%this file allows you to partition your data 
%and analyze them by part


% Initialize the cell array
ranges = cell(1, 6);
% Populate the cell array with range pairs
ranges{1} = [1, 10];
ranges{2} = [10, 20];
ranges{3} = [20, 30];
ranges{4} = [30, 40];
ranges{5} = [40, 50];
ranges{6} = [50, 60];
for j = 30:32
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    normalizer = 0;
    begin = j;
    iteration=j;
    for i = begin:iteration 
        filename = sprintf('C:\\Users\\Dirk\\Desktop\\purcell\\05132024\\fourth_fuck\\fourthfuck_%d.mat', i);
        data = load(filename);
        % initialize
        t = data.data.Time;
        gate = data.data.Dev1_ai0;
        cts = data.data.Dev1_ctr2 ;
            real_flag=flagfinder(gate);
        normalizer = normalizer + length(real_flag);
        real_decay = generator(real_flag,cts);
        %plot the sum of the test_decay
        if i ==begin
            bitch = sum(real_decay);
        else
            bitch = [bitch;sum(real_decay)];
        end
        disp(i);
    end
    figure;
    john = sum(bitch);
    dt = 8e-6;%s
    subplot(2,1,1)
    plot((1:length(john))*dt,john)
    xlabel('time (s)'); % Label x-axis
    ylabel('counts'); % Label y-axis
    %ylim([0 300]);
    title(sprintf('from %d to %d',begin,iteration))
    subplot(2,1,2)
    scatter((1:length(john))*dt,john,0.5)
    xlabel('time (s)'); % Label x-axis
    ylabel('counts'); % Label y-axis
    title(sprintf("sum over %d on/off by chopper. Total acquire time = %d mins",normalizer,iteration-begin)); % Title of the plot
    ylim([0 1000]);
    twitch = 1; %change this to 1 if you want to save it
    if twitch == 1
        filename = sprintf('decay_pattern_%d_%d.fig', begin, iteration);
        folder = 'C:\Users\Dirk\Desktop\purcell\05132024\4th_analysis\individual_plot\';
        saveas(gcf, [folder filename]);
        disp(sprintf('Saved! %s', [folder filename]));
            % Calculate time values
        time_values = (1:length(john)) * dt;
        % Combine time and counts into a 2xN matrix
        source_data = [time_values; john];
        % Save the source_data matrix
        mat_filename = sprintf('source_data_%d_%d.mat', begin, iteration);
        save([folder mat_filename], 'source_data');
        disp(sprintf('Data saved! %s', [folder mat_filename]));
    end

end
















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







