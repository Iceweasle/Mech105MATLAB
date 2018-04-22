function [root,fx,ea,iter] = falsePosition(func,xl,xu,es,maxiter,andor)
%falseposition takes a function defined by the user and approximates the
%roots of the function given two bracket points. The roots are provided provided given constraints on the
%iterations preformed by the approx. and the minimum error desired.

%   func=function defined by user
%   xl= lower bound bracket
%   xu= upper bound bracket
%   es= minimum error of root approximation
%   maxiter= maximum iterations of approximations to  be preformed
%   andor= if equal to 1 then the approximation loops untill both es and
%   maxiter are met
%   
%   User must first define a function as 'func' Then call the function, 'falseposition()' and
%   input a minimum of three arguments and up to 6:
%   falseposition(func,xl,xu,{es},{maxiter},{andor}). With an input of only
%   three arguments, the function will approximate until the error is
%   reasonably small. If user inputs zero for minimum
%   error (es) with a maxiter value, then the program will only utilize max iterations (maxiter)
%   as the caping point of the approximation of the roots. Conversely, if
%   the user inputs 0 as the value for the maxiter with a minimum error value, then the code will only
%   utilize minimum error (es) as the ending criteria for the loop. If both values are
%   given then the function will,by default, be evaluated in an 'and' senario as in the
%   function stops when one of the two criterion are met. Additionally,the
%   user may input a value of 1 in for the 'andor' argument, in which case
%   the function will be evaluated until both criteria are met and display
%   both values for each constraining criteria.

%% input errors
    if nargin<3 %checks for minimum number of arguments
    error('Please input at least three arguments')
    end
    
    if nargin>6 %checks for too many arguments
    error('please input a maximum of three arguments')
    end
    
    fxu=func(xu);%function evaluated at xu
    fxl=func(xl);%function evaluated at xl

    if sign(fxu) == sign(fxl) %checks for valid input of fxu and fxl (makes sure both have different signs).
       error('please input upper and lower bounds that have different signs when evaluated by the function')
    end



if nargin==3 %when there are 3 input arguments
%% 3 Arguments
  ea=100; %defines estimated error at 1 iteration to be 100 percent
    while ea>=.0001 %stopping criteria is defaulted to an error of .0001% 
        fxu=func(xu);%evaluates function at lower bound
        fxl=func(xl);%evaluates function at upper bound
        xr=xu-((fxu*(xl-xu))/(fxl-fxu));%the false position root approximation
        fxr=func(xr);%evaluates function at root approximation
        if sign(fxr)== sign(fxl) %replaces a bound with the xr approximation depending of the sign of xr.
            xl=xr;
        else 
            xu=xr;
        end
        fxu=func(xu);%evaluates function at lower bound
        fxl=func(xl);%evaluates function at upper bound
        xr2=xu-((fxu*(xl-xu))/(fxl-fxu)); %new root approximation given the new lower/upper bound
        ea=abs((xr2-xr)/xr2)*100;%error between iteration
        if ea>.01 %while the criteria are met, either xl or xu must be redefined given the new root approx xr2
            fxr2=func(xr2);%function evaluated at the most current root approximation.
            if sign(fxr2)== sign(fxl) %replaces a bound with the xr approximation depending of the sign of xr.
            xl=xr2;
            else 
            xu=xr2;
            end
        else
            break %breaks out of while loop if the criteria are met within the first iteration or any iteration
        end
    end
    root=xr2; %root approximation is the most current xr2 value.
    fx=func(xr2); %this is the value of the function evaluated at the most current root approximation. This should be near zero if not a very small number. will never actually be zero.
    formatSpec= 'The root occurs at indvar= %e at which point the function evaluates to %e with an error of %e percent.';
    fprintf(formatSpec,root,fx,ea); %prints a string with output values listed
  

elseif nargin==4 %when there are exactly 4 arguments
%% 4 Arguments
  ea=100; %defines initial error approximation as 100 percent
    while es<=ea %stopping criteria: when ea is greater than es, the loop stops 
        fxu=func(xu);%evaluates function at lower bound
        fxl=func(xl);%evaluates function at upper bound
        xr=xu-((fxu*(xl-xu))/(fxl-fxu));%the false position root approximation
        fxr=func(xr); %evaluates function at the root approximation
        if sign(fxr)== sign(fxl) %replaces a bound with the xr approximation depending of the sign of xr.
            xl=xr;
        else 
            xu=xr;
        end
        fxu=func(xu);%evaluates function at lower bound
        fxl=func(xl);%evaluates function at upper bound
        xr2=xu-((fxu*(xl-xu))/(fxl-fxu)); %new error approximation given the new xl/xu value.
        ea=abs((xr2-xr)/xr2)*100; %most current error approximation
        if ea>es %while the criteria are not met, the approximation bounds are redefined
            fxr2=func(xr2);
            if sign(fxr2)== sign(fxl) %replaces a bound with the xr approximation depending of the sign of xr.
            xl=xr2;
            else 
            xu=xr2;
            end
        else
            break %breaks out of while loop if criteria are met
        end
    end
    root=xr2;
    fx=func(xr2);
    formatSpec= ' The root occurs at indvar= %e at which point the function evaluates to %e with an error of %e percent.';
    fprintf(formatSpec,root,fx,ea);
    



elseif nargin==5 %when there is exactly 5 arguments, the approximating stops when the one of the stopping criteria is met.
    %% 5 Arguments
    if es==0 && maxiter==0 %makes sure at least one of the two stopping criterion has a usable value.
    error('minimum error and maximum iteration cannot both be zero, read the discription for assistance')
    end
  iter=0;%starting iteration is 0
  ea=100; %starting error is 100 percent
  
  % Stopping criteria are es and maxiter
  if es~=0 && maxiter~=0
    while es<=ea && iter<maxiter % stopping criteria   
        fxu=func(xu);%evaluates function at lower bound
        fxl=func(xl);%evaluates function at upper bound
        xr=xu-((fxu*(xl-xu))/(fxl-fxu));%the false position root approximation
        fxr=func(xr);
        if sign(fxr)== sign(fxl) %replaces a bound with the xr approximation depending of the sign of xr.
            xl=xr;
        else 
            xu=xr;
        end
        fxu=func(xu);%evaluates function at lower bound
        fxl=func(xl);%evaluates function at upper bound
        xr2=xu-((fxu*(xl-xu))/(fxl-fxu));
        ea=abs((xr2-xr)/xr2)*100;
        iter=iter+1;
        if ea>es || iter<maxiter
            fxr2=func(xr2);
            if sign(fxr2)== sign(fxl) %replaces a bound with the xr approximation depending of the sign of xr.
            xl=xr2;
            else 
            xu=xr2;
            end
        else
            break
        end
    end
     root=xr2;
    fx=func(xr2);
    formatSpec= ' The root occurs at indvar= %e at which point the function evaluates to %e with an error of %e percent at %d iterations.';
    fprintf(formatSpec,root,fx,ea,iter);
    
 %Stopping criteria is minimum error
  elseif es~=0 && maxiter==0
       while es<=ea %stopping criteria 
        fxu=func(xu);%evaluates function at lower bound
        fxl=func(xl);%evaluates function at upper bound
        xr=xu-((fxu*(xl-xu))/(fxl-fxu));%the false position root approximation
        fxr=func(xr);
            if sign(fxr)== sign(fxl) %replaces a bound with the xr approximation depending of the sign of xr.
            xl=xr;
            else 
            xu=xr;
            end
         fxu=func(xu);%evaluates function at lower bound
         fxl=func(xl);%evaluates function at upper bound
         xr2=xu-((fxu*(xl-xu))/(fxl-fxu));
         ea=abs((xr2-xr)/xr2)*100;
            if ea>es
                fxr2=func(xr2);
                if sign(fxr2)== sign(fxl) %replaces a bound with the xr approximation depending of the sign of xr.
                xl=xr2;
                else 
                xu=xr2;
                end
            else
                break
            end
       end
      root=xr2;
    fx=func(xr2);
    formatSpec= ' The root occurs at indvar= %e at which point the function evaluates to %e with an error of %e percent.';
    fprintf(formatSpec,root,fx,ea);
 % Stopping criteria is max iterations
  elseif es==0 && maxiter~=0
      while iter<maxiter % stopping criteria   
        
        fxu=func(xu);%evaluates function at lower bound
        fxl=func(xl);%evaluates function at upper bound
        xr=xu-((fxu*(xl-xu))/(fxl-fxu));%the false position root approximation
        fxr=func(xr);
            if sign(fxr)== sign(fxl) %replaces a bound with the xr approximation depending of the sign of xr.
            xl=xr;
            else 
            xu=xr;
            end
        fxu=func(xu);%evaluates function at lower bound
        fxl=func(xl);%evaluates function at upper bound
        xr2=xu-((fxu*(xl-xu))/(fxl-fxu));
        ea=abs((xr2-xr)/xr2)*100;
        iter=iter+1;
            if iter<maxiter
                fxr2=func(xr2);
                if sign(fxr2)== sign(fxl) %replaces a bound with the xr approximation depending of the sign of xr.
                xl=xr2;
                else 
                xu=xr2;
                end
            else
                break
            end
      end
     root=xr2;
    fx=func(xr2);
    formatSpec= ' The root occurs at indvar= %e at which point the function evaluates to %e with an error of %e percent at %d iterations.';
    fprintf(formatSpec,root,fx,ea,iter);
  end


elseif nargin==6
%% 6 arguments
    if andor == 1% when andor is true, the approximation will continue to loop untill both conditions are met to end the while loop.
  iter=1;
  if es==0 || maxiter==0 %approximation will not work if either of the values are zero.
      error('if andor argument is in use, the values of es and maxiter must be defined as positive integers')
  end
  ea=100;
    while es<=ea || iter<maxiter %stopping criteria dependent on both vatiables
        fxu=func(xu);%evaluates function at lower bound
        fxl=func(xl);%evaluates function at upper bound
        xr=xu-((fxu*(xl-xu))/(fxl-fxu));%the false position root approximation
        fxr=func(xr);
        if sign(fxr)== sign(fxl) %replaces a bound with the xr approximation depending of the sign of xr.
            xl=xr;
        else 
            xu=xr;
        end
        fxu=func(xu);%evaluates function at lower bound
        fxl=func(xl);%evaluates function at upper bound
        xr2=xu-((fxu*(xl-xu))/(fxl-fxu));
        ea=abs((xr2-xr)/xr2)*100;
        iter=iter+1;
        if ea>es || iter<maxiter
            fxr2=func(xr2);
            if sign(fxr2)== sign(fxl) %replaces a bound with the xr approximation depending of the sign of xr.
            xl=xr2;
            else 
            xu=xr2;
            end
        else
            break
        end
    end
    
    else
         error('the andor argument must be a value of 1 otherwise exlude the argument all together.') %spits an error if the user puts anything other thn 1 in for andor argument.
    end
    root=xr2;
    fx=func(xr2);
    formatSpec= ' The root occurs at indvar= %e at which point the function evaluates to %e with an error of %e percent at %d iterations.';
    fprintf(formatSpec,root,fx,ea,iter);
 end
end
    
           

