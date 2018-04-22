function [L,U,P] = luFactor(A)
%luFactor will convert any square matrix into an upper, lower, and pivot
%matrix.
%   INPUTS: 
%   A- any square matrix
%   OUTPUTS:
%   L- Lower Triangular Matrix
%   U- Upper Triangular Matrix
%   P- Pivot Matrix
%   The user must input exactly one argument as a matrix or a variable
%   containing a matrix. Through LU Factorization, this function will first
%   identify if an initial pivot is necessary then proceed to eliminate
%   terms. The elimination step multiplies the first two rows by a constant
%   which is determined by the quotient of the first coeficients of the two
%   rows. At this point the first term of the second row can be eliminated.
%   A similar process is implimented in the first and third rows. Next, the
%   function will check if another pivot is needed to eliminate the second
%   term of the third row. The L matrix is developed using the quotient
%   constants in their respective locations in a modified indentity matrix.
%   After the final pivot and the last elimination, the P matrix is
%   completed by matching the pivots preformed on A to create U. U is the
%   matrix resulting from the eliminations and pivots on matrix A. L, U,
%   and P are then output from the function. 
%------------------------------------------------------------------------------
%% Input Checks
if nargin ~= 1
    error(' please input exactly one matrix as the only argument.')
end
r=0; %rows
c=0; %collumns
[r,c]=size(A);

if r~=c %checks for square matrix
    error('please input a square matrix where the number of rows and collummns are equal')
end
%% Define L, U, and P
L=eye(r,c); %lower triangular matrix
U=A; %upper triangular matrix
P=L; %pivot matrix
%% LU Factorization
for x=1:r
    [M,i]=max(abs(U(x:r,x))); %stores max abs value as M and stores its row value as i.
    i=i+x-1;
    if i~=x %if i is the max value, the pivot first pivot is skipped
           %Pivot and Update U matrix
        y=U(x,:); %stores row values for pivot
        U(x,:)=U(i,:); % replaces top row with max value row
        U(i,:)=y; %moves other row down to relace and complete the pivot
    
        %Pivot and Update P matrix
        y=P(x,:); %stores row values for pivot
        P(x,:)=P(i,:); % replaces top row with max value row
        P(i,:)=y; %moves other row down to relace and complete the pivot
    
        %Pivot L matrix
            if x>1 %must skip first round because L matrix is not altered yet
                y=L(x,1:x-1);%stores single cell value for pivot
                L(x,1:x-1)=L(i,1:x-1);%redefine first row
                L(i,1:x-1)=y;%redefine second row
            end
    end
    
         %Build L and U matrices
        for y=x+1:r %the for loop itterates through
            L(y,x)=U(y,x)/U(x,x); %stores multiplicant coefficients in L
            U(y,:)=U(y,:)-L(y,x)*U(x,:); %builds U by row subtraction
        end
end
%Display Matrices
L
U
P
end



