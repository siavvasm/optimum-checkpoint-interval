function [tau] = tauCalculation(n,B,L,c,a,b0,b1)
    
    CnL = b0*(a^(-1*n*L)-1) + ((c+b1)/(1-a))*(a^(-1*n*L)-1) - b1*n*L;
    tau = (B + CnL) / (n*L);
   
end
