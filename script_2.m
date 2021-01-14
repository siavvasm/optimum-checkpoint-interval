%% Clear the Workspace and close open windows
clear all
close all

%% n1
a = 1;
b = 0;

p0 = a * 100 + b * 100;
p1 = a * 10 + b * 10;

cp_0 = a * 100000 + b * 500;
cp_1 = a * 0 + b * 0;

f = 1 - 0.000005;
l = 100;
I = 1000000;
n = I/l;
Y = I;


cp = cp_0 + cp_1 * I;

c = a * 1 + b * 10^(-5);

T = [];
k_x =[];
tot = totalExpectedExecutionTimeCP(n*l, f, p0, p1, c);
ck_x = [];

for n=1:1:n
    T(n) = tot;
    k_x(n) = kappaCalculation(n,l,cp_0,cp_1,Y,c,f,p0,p1);
end


ck_x = k_x * Y;

[value_numer,index_numer] = min(k_x);
n_1 = index_numer;
n_1_analyt = round(n_star_analytic(c,p0,p1,cp,1-f,l));

%% n2
a = 0;
b = 1;

p0 = a * 100 + b * 100;
p1 = a * 10 + b * 10;

cp_0 = a * 100000 + b * 500;
cp_1 = a * 0 + b * 0;

cp = cp_0 + cp_1 * I;

c = a * 1 + b * 10^(-5);

Te = [];
k_e =[];
tote = totalExpectedExecutionTimeCP(n*l, f, p0, p1, c);
ck_e = [];

for n=1:1:n
    Te(n) = tote;
    k_e(n) = kappaCalculation(n,l,cp_0,cp_1,Y,c,f,p0,p1);
end

ck_e = k_e * Y;

[value_numer_ener,index_numer_ener] = min(k_e);
n_2 = index_numer_ener;
n_2_analyt = round(n_star_analytic(c,p0,p1,cp,1-f,l));

%% n3
a = 1;
b = 1;

p0 = a * 100 + b * 100;
p1 = a * 10 + b * 10;

cp_0 = a * 100000 + b * 500;
cp_1 = a * 0 + b * 0;

cp = cp_0 + cp_1 * I;

c = a * 1 + b * 10^(-5);

n_3 = round(n_star_analytic(c,p0,p1,cp,1-f,l));

%% PLOTS - Expected Execution Time

figure(1);
loglog(1:n,T)
hold on
loglog(1:n,ck_x);
hold on;
title('Expected Execution Time Comparison')
xlabel('n: Checkpoint Interval - Loop iterations between checkpoints')
ylabel('Expected Execution Time')
legend('Execution Time without Checkpoints','Execution Time with Checkpoints')
ylim([10^6 10^10]);
hold off;
hold on
plot(n_1_analyt,ck_x(n_1_analyt),'rs','MarkerSize',8);
plot(n_2_analyt,ck_x(n_2_analyt),'ro','MarkerSize',8);
plot(n_3,ck_x(n_3),'rd','MarkerSize',8);
legend('Execution Time without Checkpoints','Execution Time with Checkpoints','n^*: Minimum Execution Time (\a = 1, \b = 0)', 'n^+: Minimum Energy Consumption (\a = 0, \b = 1)', 'n^o: Global Minimum (\a = 1, \b = 1)')

%% PLOTS 
figure(2);
loglog(1:n,Te)
hold on
loglog(1:n,ck_e);
hold on;
title('Expected Energy Consumption Comparison')
xlabel('n: Checkpoint Interval - Loop iterations between checkpoints')
ylabel('Expected Energy Consumption')
legend('Energy Consumption without Checkpoints','Energy Consumption with Checkpoints')
ylim([10^5 10^11])
hold off;
hold on
plot(n_1_analyt,ck_e(n_1_analyt),'rs','MarkerSize',8);
plot(n_2_analyt,ck_e(n_2_analyt),'ro','MarkerSize',8);
plot(n_3,ck_e(n_3),'rd','MarkerSize',8);
legend('Execution Time without Checkpoints','Execution Time with Checkpoints','n^*: Minimum Execution Time (\a = 1, \b = 0)', 'n^+: Minimum Energy Consumption (\a = 0, \b = 1)', 'n^o: Global Minimum (\a = 1, \b = 1)')




