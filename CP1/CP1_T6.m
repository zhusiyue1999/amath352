%%
%

clear all; close all;
r = RandStream('mt19937ar','Seed',1234);
A = r.randn(6, 7);
A
[n, m]=size(A);
out = [];
S = [];
for i = 1 : n - 1
    pivot = i;
    for j = i + 1 : n
        if abs(A(pivot, i)) > abs(A(j, i))
            pivot = j;
        end
        S = A(pivot, :);
        A(pivot, :) = A(j, :);
        A(j, :) = S;
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
save CP1_T6.dat out -ascii

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
save CP1_T6.dat out -ascii