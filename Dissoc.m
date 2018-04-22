function [outputArg1,outputArg2] = Dissoc(k,pt,x)
%Dissoc : ** enter 'syms k pt x' into workspace before using function.**
%this function uses the dissociation equation in terms of 
%equilibrium constant,total pressure of the system, and the mole fraction
%of the reactants. The function requires 2 numerical arguments and one
%variable defined by its respective letter/s. 
%   ----------------------------------------------------------------------
%   k = equilibrium constant
%   Pt= Pressure of the system
%   x= mole fraction of reactants
%   To utilize this function properly, the user needs to provide 2
%   numerical values so the dissociation equation can be solved for the
%   third, unvalued term. For example, if the user inputs 'Dissoc(.05,3,x)'
%   then the function will output a value for x. Three arguments total
%   are required. For the non-numerical value, the user put the
%   variable that is being left out. That means one of the following must
%   be used in the correct orientation: k,Pt,x
%   -----------------------------------------------------------------------

%% Errors

%insures there are at least three arguments
if nargin ~=3 
    error('Please input exatly 3 arguments. Two numerical values and one variable to solve for.')
end

%insures there are two known values to work with
if isnumeric(k)==false && (isnumeric(pt)==false || isnumeric(x))== false 
    error(' There must be at least two numeric values as arguments in order for the function to evaluate the dissociation equation')
end

%insures there are two known values to work with
if (isnumeric(k)==false || isnumeric(pt))==false && isnumeric(x)== false 
    error(' There must be at least two numeric values as arguments in order for the function to evaluate the dissociation equation')
end
%% The Three Solutions

%Solve for K:
if isnumeric(k)== false 
    %If k is non-numeric,
    k=(x/(1-x))*sqrt(2*pt/(2+x))
        %Function is solved given x and pt values.
        
%Solve for pt:
elseif isnumeric(pt)== false 
    %If pt is non-numeric,
    func=@(pt) (x/(1-x))*sqrt(2*pt/(2+x))-k;
    pt=fzero(func,3.01076)
        %func is set = 0 then solved for using fzero function.
        
%Solve for x:
elseif isnumeric(x)== false
    %If x is non-numeric,
    func=@(x) (x/(1-x))*sqrt(2*pt/(2+x))-k;
    x=fzero(func,0)
        %func is set = 0 then solved for using fzero function.
        
%If you are incompetent, 
else 
    error('please leave at least one of the arguments as a non-numeric value in order to obtain its respective value.')
end

end

%%inputs used:

% syms k pt x
%Dissoc(.05,3,x)