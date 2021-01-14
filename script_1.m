%% Clear the Workspace and close open windows
clear all
close all

%% Execute the model

cp_x = 100000;
l = 100;
e = 1;
s = 1 - 0.000005;
k0 = 100;
k1 = 10;
I = 10000;
cp_n = 500;
en = 10^(-5);

t = [];
te = [];
T = [];
Te = [];

tot1 = totalExpectedExecutionTimeCP(I*l, s, k0, k1, e);
tot2 = totalExpectedExecutionTimeCP(I*l, s, k0, k1, en);

for n=1:I
    T(n) = tot1;
    Te(n) = tot2;
    t(n) = tauCalculation(n,cp_x,l,e,s,k0,k1);
    te(n) = tauCalculation(n,cp_n,l,en,s,k0,k1);
end

[value,index] = min(t);
n1 = index;

disp("value:"), disp(value)
disp("index:"), disp(index)

[value,index] = min(te);
n2 = index;

disp("value:"), disp(value)
disp("index:"), disp(index)

t = t * (I*l);
te = te * (I*l);

%% Plot Graphs

figure(1)
loglog(1:I,T,'--')
hold on;
loglog(1:I,t);
title('Execution Time Comparison');
xlabel('n: Number of Loop Repetitions between Checkpoints');
ylabel('Expected Execution Time');
plot(n1,t(n1),'rs','MarkerSize',8);
plot(n2,t(n2),'ro','MarkerSize',8);
legend('Expected Execution Time without Checkpoints','Expected Execution Time with Checkpoints', 'Minimum Execution Time (n^o)', 'Minimum Energy Consumption (n^+)');
ylim([2000000 10000000000])

figure(2)
loglog(1:I,Te,'--')
hold on;
loglog(1:I,te);
title('Energy Consumption Comparison');
xlabel('n: Number of Loop Repetitions between Checkpoints');
ylabel('Expected Energy Consumption');
plot(n2,te(n2),'rs','MarkerSize',8);
plot(n1,te(n1),'ro','MarkerSize',8);
legend('Expected Execution Time without Checkpoints','Expected Execution Time with Checkpoints', 'Minimum Energy Consumption (n^+)','Minimum Execution Time (n^o)');
ylim([100000 100000000000])





