function [kappa] = kappaCalculation(n,L,B_0, B_1,Y,c,a,b0,b1)
    
    CnL = b0*(a^(-1*n*L)-1) + ((c+b1)/(1-a))*(a^(-1*n*L)-1) - b1*n*L;
    %tau = (B + Cy) / (y);
    
    kappa = ((B_0 + (B_1 * Y) + CnL) / (n*L)) + B_1;
   
end
