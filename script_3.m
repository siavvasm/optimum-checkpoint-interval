%% Clear the Workspace and close open windows
clear all
close all

%% Setup and Model Execution
a = 1;
b = 0;
p0 = a * 100 + b * 100;
p1 = a * 10 + b * 10;
cp_0 = a * 1000 + b * 100;
cp_1 = a * 0 + b * 0;
k = a * 1 + b * 10^(-5);

% Params
cp = 100;
l = 100;
I = 10000000;
N = I/l;
f = simulatedF(I);
s = 1 - f;
Y = I;
cp_0 = cp_0;
cp_1 = cp_1;
p0 = p0;
p1 = p1;
t = [];
kl = [];
c_kl = [];
T = [];

total = totalExpectedExecutionTimeCP(N*l, s, p0, p1, k);
for n=1:N
    T(n) = total;
    t(n) = tauCalculation(n,cp,l,k,s,p0,p1);
    kl(n) = kappaCalculation(n,l,cp_0, cp_1,Y,k,s,p0,p1);
end

c_kl = kl * Y;

[value,index] = min(t);
n_0 = index;

[value_k,index_k] = min(kl);
n_0_k = index_k;

disp("value kappa:"), disp(value_k)
disp("index kappa:"), disp(index_k)

%% Plots
graph = figure(1);
loglog(1:n,T,'--')
hold on
loglog(1:n,c_kl);
hold on;
title('Execution Time Comparison')
xlabel('n: Number of Loop Repetitions between Checkpoints')
ylabel('Expected Execution Time')
legend('Execution Time without Checkpoints','Execution Time with Checkpoints')
hold off;

hold on
plot(n_0_k,c_kl(n_0_k),'rs','MarkerSize',8);
legend('Execution Time without Checkpoints','Execution Time with Checkpoints','Minimum Execution Time')

figure(2);
G = ((T - c_kl)./T)*100;
plot(G)
hold on
title('G in terms of expected execution time')
xlabel('n: Number of loop repetitions between Checkpoints')
ylabel('G (%)')
hold off
S = 1;
if S ~= 0
    hold on
    plot(n_0_k,G(n_0_k),'rs','MarkerSize',8)
end
x = zeros(1, length(G));
plot(x,'--')
legend('G','Maximum G')
hold off
ylim([-20 100])