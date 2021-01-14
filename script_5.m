%% Clear the Workspace and close open windows
clear all
close all

%% Compute n0, n*, and n+
a = 1;
b = 0;
k_x = 1;
l = 100;
I = 1000000;
n = I/l;
k_e = 10^(-5);
f = 1 - 0.000005;
S = I;

n_opt = [];
for b=0:1:100
    % Update the parameters
    p0 = a * 100 + b * 100;
    p1 = a * 10 + b * 10;

    cp_0 = a * 100000 + b * 500;
    cp_1 = a * 0 + b * 0;

    cp = cp_0 + cp_1 * I;

    k = a * k_x + b * k_e;
    
    % Calculate the optimum 
    temp = n_star_analytic(k,p0,p1,cp,1-f,l);
    n_opt(b+1) = temp;
end

a = 1;
b = 0;

p0 = a * 100 + b * 100;
p1 = a * 10 + b * 10;
cp_0 = a * 100000 + b * 500;
cp_1 = a * 0 + b * 0;
cp = cp_0 + cp_1 * I;

k = a * k_x + b * k_e;

% Calculate the optimum 
n_0 = n_star_analytic(k,p0,p1,cp,1-f,l);

a = 0;
b = 1;

% Update the parameters
p0 = a * 100 + b * 100;
p1 = a * 10 + b * 10;
cp_0 = a * 100000 + b * 500;
cp_1 = a * 0 + b * 0;
cp = cp_0 + cp_1 * I;

k = a * k_x + b * k_e;

% Calculate the optimum 
n_1 = n_star_analytic(k,p0,p1,cp,1-f,l);

%% Plots 
figure(1);
plot(0:100,n_opt);
hold on;
n_star_ar = ones(1,101);
n_plus_ar = ones(1,101);
n_star_ar = n_star_ar * n_0;
n_plus_ar = n_plus_ar * n_1;
plot(0:100,n_star_ar,"--");
plot(0:100,n_plus_ar,"--");
ylim([0 800]);
legend("n^*: The global optimum checkpoint interval", "n^o: Checkpoint Interval that minimizes execution time (\b = 0)", "n^+: Checkpoint interval that minimizes energy consumption (\a = 0)")
title("Global Optimum Checkpoint Interval against parameter \b")
xlabel("\b")
ylabel("n^*: The global optimum checkpoint interval")
txt = "n^o";
text(95,575,txt);
txt = "n^+";
text(95,25,txt);