%% Clear the Workspace and close open windows
clear all
close all

%% Setup and model execution
a = 1;
b = 0;

c_c = 0.0000067235;
c_c = 0.0000000097235;
c_e = 0.00000000003345;

p0 = a * 0.000000031 + b * 0.000000752;
p1 = a * 0.000000031 + b * 0.00000000651;

cp_0 = a * 0.00347 + b * 0.0059;
cp_1 = a * 0 + b * 0;

k = a * c_c + b * c_e;

cp = cp_0 + cp_1; 
l = 4804;
N = 2090;
s = 1 - simulatedS(l*N);

Y = N * l;
t = [];
kl = [];
ckl = [];
T = [];

total = totalExpectedExecutionTimeCP(N*l, s, p0, p1, k);
for n=1:N
    T(n) = total;
    t(n) = tauCalculation(n,cp,l,k,s,p0,p1);
    kl(n) = kappaCalculation(n,l,cp_0, cp_1,Y,k,s,p0,p1);
end

ckl = kl * Y;

[value,index] = min(t);
n_0 = index;

[value_k,index_k] = min(kl);
n_0_k = index_k;

disp("value kappa:"), disp(value_k)
disp("index kappa:"), disp(index_k)

%% Plots
graph = figure(1);
loglog(1:N,T,'--')
hold on
loglog(1:N,ckl);
hold on;
title('Execution Time Comparison')
xlabel('n: Number of Loop Repetitions between Checkpoints')
ylabel('Expected Execution Time')
legend('Execution Time without Checkpoints','Execution Time with Checkpoints')
hold off;
hold on
plot(n_0_k,ckl(n_0_k),'rs','MarkerSize',8);
legend('Execution Time without Checkpoints','Execution Time with Checkpoints','Minimum Execution Time (n^o)')

figure(2);
G = ((T - ckl)./T)*100;
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
legend('G','Maximum G (n^o)')
hold off
ylim([-20 100])