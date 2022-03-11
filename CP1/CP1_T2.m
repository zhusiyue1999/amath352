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