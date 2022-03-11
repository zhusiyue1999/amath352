%%
%

clear all; close all;
r = RandStream('mt19937ar','Seed',1234);
A = r.randn(6, 7);
[n, m]=size(A);
out=[];
for i = 1 : n - 1
    pivot = i;
    for k = i + 1 : n
        if abs(A(pivot,i)) < abs(A(k,i))
            pivot = k;
        end
        B = A(pivot, :);
        A(i, :) = A(pivot, :);
        A(pivot, :) = B;
    end
    
    for j = i + 1 : n
        if A(i,i) == 0
            error('Method failed: pivoting needed')
        end
        A(j, :) = A(j, :) - A(j,i)/A(i,i) * A(i, :);
    end
    out = [out;A];
end
out;
save CP1_T4.dat out -ascii

%%
%

clear all; close all;
r = RandStream('mt19937ar','Seed',1234);
A = r.randn(6, 7);
[n, m]=size(A);
out=[];
for i = 1 : n - 1
    pivot = i;
    for j = i + 1 : n
        if abs(A(pivot,i)) < abs(A(j,i))
            pivot = j;
        end
        B = A(pivot, :);
        A(pivot, :) = A(j, :);
        A(j, :) = B;
    end
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

r = RandStream('mt19937ar','Seed',1234);
A = r.randn(6, 7);
out=[];
[n, m]=size(A);
B = [];
for i = 1 : (n - 1)
    povit = i;
    for j = povit + 1 : n
        if abs(A(povit, i)) < abs(A(j, i))
            povit = j;
        end
        B = A(povit, :);
        A(povit, :) = A(j, :);
        A(j, :) = B;
    end
    for j = i + 1 : n
        if A(i, i) == 0
            error('Method failed: pivoting needed')
        else
            A(j, :) = A(j, :) - A(j, i)/A(i, i) * A(i, :);
        end
    end
    A;
    out = [out; A];
end
out
save CP1_T4.dat out -ascii
