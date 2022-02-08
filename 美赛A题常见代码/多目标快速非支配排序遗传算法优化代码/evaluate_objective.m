function f = evaluate_objective(x, M) % modified by zzb

%% function f = evaluate_objective(x, M, V)
% Function to evaluate the objective functions for the given input vector
% x. x is an array of decision variables and f(1), f(2), etc are the
% objective functions. The algorithm always minimizes the objective
% function hence if you would like to maximize the function then multiply
% the function by negative one. M is the numebr of objective functions and
% V is the number of decision variables. 
%
% This functions is basically written by the user who defines his/her own
% objective function. Make sure that the M and V matches your initial user
% input. Make sure that the 
%
% An example objective function is given below. It has two six decision
% variables are two objective functions.
% f = [];
%% Objective function one
% Decision variables are used to form the objective function.
% f1 = 1 - exp(-4*x(1))*(sin(6*pi*x(1)))^6;
% Intermediate function
%sum = 0;
%for i = 2 : 6
%    sum = sum + x(i)/4;
%end
%g_x = 1 + 9*(sum)^(0.25);
% Objective function two
%f2 = g_x*(1 - ((f1)/(g_x))^2);
% Objective function
%f = [f1 f2];
%% MOP2
% Intermediate function
sum = 0;
for i = 3 : 12
    sum = sum + (x(i) - 0.5)^2;
end
g_x = sum;
% Objective function one
f1 = (1 + g_x)*cos(0.5*pi*x(1))*cos(0.5*pi*x(2));
% Objective function two
f2 = (1 + g_x)*cos(0.5*pi*x(1))*sin(0.5*pi*x(2));
% Objective function three
f3 = (1 + g_x)*sin(0.5*pi*x(1));
% Objective function
f = [f1 f2 f3];
%% Check for error
if length(f) ~= M
    error('The number of objective functions does not match you previous input. Kindly check your objective function.');
end