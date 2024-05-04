a=moku.data(:,1)%trigger
b=moku.data(:,2)%trans
c=moku.data(:,3)%mzi
d=moku.data(:,4)

figure;
subplot(3, 1, 1); 
plot(a);
xlabel('Samples');
ylabel('Voltage');
title('Channel 2, piezo');

subplot(3, 1, 2); 
plot(b);
xlabel('Samples');
ylabel('Voltage');
title('Channel 3, trans');
disp('done')

subplot(3, 1, 3); 
plot(d);
xlabel('Samples');
ylabel('Voltage');
title('Channel 4,error');
disp('done')