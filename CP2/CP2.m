%%
%

clear all; close all;
r = RandStream('mt19937ar','Seed',1234);
A = r.randn(6,6);
[n, m]=size(A);
P = (1:n)';
M = A;
out = [];
for i = 1 : n - 1
    k = i;
    for l = i : n
        if abs(M(k,i)) < abs(M(l,i))
            k = l;
        end
    end
    B = M(k, :);
    M(k, :) = M(i, :);
    M(i, :) = B;
    C = P(i);
    P(i) = P(k);
    P(k) = C;
    if M(i,i) == 0
        error("Matrix is rank deficient")
    end
    for j = i + 1 : n
        a = M(j,i)/M(i,i);
        M(j,i:end) = M(j,i:end) - a*M(i,i:end);
        M(j,i) = a;
    end
    answer = [P,M];
    out = [out; answer];
end
out
save CP2_T1.dat out -ascii

%%
%

clear all; close all;
url = 'http://faculty.washington.edu/trogdon/352/CP2_T1.mat';
filename = 'CP2_T1.mat';
outfilename = websave(filename,url);
load CP2_T1.mat

r = RandStream('mt19937ar','Seed',1234);
A = r.randn(6,6); 
b = [1;0;1;0;1;0];
p = O(:, 1);
I = eye(6);
L = tril(O(:, 2:7), -1) + I;
U = triu(O(:, 2:7));
z = applyP(p, b);
y = Forsub([L,z]);
x = Backsub([U,y]);
out = [z, y, x];
out
save CP2_T2.dat out -ascii

%%
%

A = [1.1,.2,-.2,.5;
     .2,.9,.5,.3;
     .1,0.,1.,.4;
     .1,.1,.1,1.2];
[n, n]=size(A);
b = [1;0;1;0];
y = zeros(n,1);
M = eye(n) - A;
E = [1e-2, 1e-4, 1e-6];
out = [];
for j = 1 : 3
    maxnum = max(abs(A*y - b));
    y = zeros(n,1);
    T = 0;
    while maxnum > E(j)
        y = M*y + b;
        T = T + 1;
        maxnum = max(abs(A*y - b));
    end
    result = [T, maxnum];
    out = [out; result];
end
out
save CP2_T3.dat out -ascii