%%
%

clear all; close all;
r = RandStream('mt19937ar','Seed',1234);
A = r.randn(6, 7);
out=[];
[n, m]=size(A);
for i = 1 : (n - 1)
    pivot = i;
    for j = pivot + 1: n
        if A(pivot, i) < A(j, i)
            pivot = j;
        end
        S = A(pivot, :);
        A(pivot, :) = A(j, :);
        A(j, :) = S;
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
save CP1_T5.dat out -ascii