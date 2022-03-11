%%
%

clear all; close all;
url = 'http://faculty.washington.edu/trogdon/352/U.mat';
filename = 'U.mat';
outfilename = websave(filename,url);
load U.mat

%r = RandStream('mt19937ar','Seed',1234);
%U = randn(6,7);
[n, m]=size(U);
x = U(:,m);
out=[];
if U(n,n) == 0
    error('Method failed: singular matrix')
else 
    x(n) = U(n,n+1)/U(n,n);
end
for i = n-1 : -1 : 1
    SUM = 0;
    if U(i,i) == 0
        error('Method failed: singular matrix')
    else
        for j = (i + 1) : n
            SUM = SUM + U(i,j) * x(j);
        end
        x(i) = U(i,n+1) - SUM;
        x(i) = x(i)/U(i,i);
    end
    %out = horzcat(out, x);
    out = [out,x];
end
out
save CP1_T3.dat out -ascii