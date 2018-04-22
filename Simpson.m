function [I] = Simpson(x,y)
%Sympsons function will integrate the y values with respect to the x values
%using the Simsons 1/3 rule for all evenly spaced intervals. If an odd
%number of intervals are present, the function will utilize the trapazoidal
%rule. This function accepts only two arguments and provides a single
%scalar output.
%   The x values are the independent variables and should be evenly spaced.
%   both x and y need to be the same length vectors.

%% Error Checks

if nargin ~=2 %checks arguments
    error('please input exactly two arguments.')
end

[r,c]=size(x);
[i,j]=size(y);

if c~=j
    error('x and y must have the same collumn length')
end

if r ~= i %ensures identically sized vectors
    error('x and y vectors must be the same row length')
end

if range(x(2:end)-x(1:end-1))~=0 %uses the range function counting through the x vector to check the spacing between each element is identical.
    error('make sure the x variable is an evenly spaced vector')
end

%% Function 
if c~=1 %puts values into collumn vectors because I wrote the code that way and need to accomidate.
    x=transpose(x);%transposes vectors
    y=transpose(y);
end

if rem(length(y),2)==1 %checks if the number of intervals is even
    
    h=(x(end,1)-x(1,1)); %the range of the intervals
        
    I=h*(y(1,1)+4*sum(y(1:2:end-1))+2*sum(y(2:2:end-1))+y(end,1))/(3*(j-1)); %simpsons 1/3 rule with even number of spaces
else
    warning('the trapazodal rule of integration will be used for the final interval'); %warns user that the trap rule is used on the last uneaven interval
    h=(x(end-1,1)-x(1,1));
    k=(x(end,1)-x(end-1,1));
    I=(h*(y(1,1)+4*sum(y(1:2:end-2))+2*sum(y(2:2:end-2))+y(end-1,1))/(3*(j-1)))+k*(y(end-1,1)+y(end,1))/2;
end

end

