%% Total Expected Execution Time - Checkpointing Scheme - C(y) %%%%%%%%%%%%
%
% This function is responsible for calculating the total expected execution 
% time of a given program that adopts the checkpointing mechanism, based on  
% the mathematical model presented in the paper. 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [C] = totalExpectedExecutionTimeCP(y,alpha,b_0,b_1,c)
    C = b_0 * (alpha^(-y)-1) + ((c + b_1)/(1 - alpha)) * (alpha^(-y)-1) - (b_1 * y);
end

