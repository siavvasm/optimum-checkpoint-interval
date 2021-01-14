%% Clear the Workspace and close open windows
clear all
close all

%% Set up and Execute the model
l = 10;
I = 10000;
N = I/l;

n_tab1=[];
n_tab2=[];
n_tab3=[];
k = 1;
g_tab = 0.00000000005:0.00000000005:0.00000005;

% Parameters for Time
a_1=10;
b_1=0;

p0_1 = a_1 * 100 + b_1 * 100;
p1_1 = a_1 * 10 + b_1 * 10;

cp0_1 = a_1 * 100000 + b_1 * 500;
cp1_1 = a_1 * 0 + b_1 * 0;

cp_1 = cp0_1 + cp1_1 * I;

k_1 = a_1 * 1 + b_1 * 10^(-5);

% Parameters for Energy
a_2=0;
b_2=10;

p0_2 = a_2 * 100 + b_2 * 100;
p1_2 = a_2 * 10 + b_2 * 10;

cp0_2 = a_2 * 100000 + b_2 * 500;
cp1_2 = a_2 * 0 + b_2 * 0;

cp_2 = cp0_2 + cp1_2 * I;

k_2 = a_2 * 1 + b_2 * 10^(-5);

% Parameters for Global Optimization
a_3=1;
b_3=10;

p0_3 = a_3 * 100 + b_3 * 100;
p1_3 = a_3 * 10 + b_3 * 10;

cp0_3 = a_3 * 100000 + b_3 * 500;
cp1_3 = a_3 * 0 + b_3 * 0;

cp_3 = cp0_3 + cp1_3 * I;

k_3 = a_3 * 1 + b_3 * 10^(-5);

for g = 0.00000000005:0.00000000005:0.00000005
    n_tab1(k) = n_star_analytic(k_1,p0_1,p1_1,cp_1,g,l);
    n_tab2(k) = n_star_analytic(k_2,p0_2,p1_2,cp_2,g,l);
    n_tab3(k) = n_star_analytic(k_3,p0_3,p1_3,cp_3,g,l);

    progress = ceil(((k/length(g_tab))*100))
    k = k + 1;
end

%% Plots
figure(1)
hold on
loglog(g_tab,n_tab1,'b');                    % n_zero
loglog(g_tab,n_tab2,'r');                    % n_plus
loglog(g_tab,n_tab3,'k', "MarkerSize",10);   % n_asterix
set(gca, "Yscale", "log");
set(gca, "Xscale", "log");
legend("n^0", "n^+", "n^*");
title('Optimum Checkpoint Interval (n) against failure probability (g)')
xlabel('g: The failure probability of the program')
ylabel('The optimum checkpoint interval (n)')
hold off
