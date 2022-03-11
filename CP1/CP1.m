%%
%

clear all; close all;
r = RandStream('mt19937ar','Seed',1234);
A = [100 1000 10000];
out=[];
for i = 1:3
    total = 0;
    for j = 1 : A(i)
        x = r.rand(1);
        y = r.rand(1);
        if y < x^2
            total = total + 1;
        end
    end
    out(1, i) = total/A(i)*(1);
end

out
save CP1_T1.dat out -ascii

%%
%

clear all; close all;
r = RandStream('mt19937ar','Seed',1234);
A = r.randn(6, 7);
[n, m]=size(A);
out=[];
for i = 1 : n - 1
    for j = i + 1 : n
        if A(i,i) == 0
            error('Method failed: pivoting needed')
        end
        A(j, :) = A(j, :) - A(j,i)/A(i,i) * A(i, :);
    end
    A;
    out = [out;A];
end
out
save CP1_T2.dat out -ascii

%%
%

clear all; close all;
url = 'http://faculty.washington.edu/trogdon/352/U.mat';
filename = 'U.mat';
outfilename = websave(filename,url);
load U.mat

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

%%
%

clear all; close all;
r = RandStream('mt19937ar','Seed',1234);
A = r.randn(6, 7);
[n, m]=size(A);
out = [];
B = [];
for i = 1 : n - 1
    pivot = i;
    for j = i + 1 : n
        if abs(A(pivot,i)) < abs(A(j,i))
            pivot = j;
        end
    end
        B = A(pivot, :);
        A(pivot, :) = A(i, :);
        A(i, :) = B;
    for j = i + 1 : n
        if A(i,i) == 0
            error('Method failed: pivoting needed')
        end
        A(j, :) = A(j, :) - A(j,i)/A(i,i) * A(i, :);
    end
    A;
    out = [out;A];
end
out
save CP1_T4.dat out -ascii