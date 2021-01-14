function [y_star,n_st] = y_star_analytic(c,b_0,b_1,B,g,L)
    alpha = 1 - g;
    A = b_0 + ((c + b_1)/(1 - alpha));
    y_star = - ((1 + lambertw(((B-A))/(A*exp(1))))/ (log(alpha)));
end
