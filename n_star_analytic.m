function [n_star,n_st] = n_star_analytic(c,b_0,b_1,B,g,L)
    alpha = 1 - g;
    A = b_0 + ((c + b_1)/(1 - alpha));
    n_star = - ((1 + lambertw(((B-A))/(A*exp(1))))/ (L*log(alpha)));
end
