%%
%

clear all; close all;
A = [1.1,.2,-.2,.5;
     .2,.9,.5,.3;
     .1,0.,1.,.4;
     .1,.1,.1,1.2];
b = [1;0;1;0];
T_j = 0;
T_gs = 0;
y = zeros(4,1);
L = tril(A, -1);
D = diag(A);
U = triu(A, +1);
LpU = L + U;
LpD = tril(A);
c_j = b./D;
c_gs = Forsub([LpD,b]);
E = [1e-2, 1e-4, 1e-6, 1e-8];
outT_j = [];
outE_j = [];
outT_gs = [];
outE_gs = [];
for i = 1 : 4
    maxnum = max(abs(A*y - b));
    y = zeros(4,1);
    T_j = 0;
    while maxnum > E(i)
        y = -(LpU*y)./D + c_j;
        T_j = T_j + 1;
        maxnum = max(abs(A*y - b));
    end
    outT_j = [outT_j, T_j];
    outE_j = [outE_j, maxnum];
end
maxnum = max(abs(A*y - b));
y = zeros(4,1);
for j = 1 : 4
    maxnum = max(abs(A*y - b));
    y = zeros(4,1);
    T_gs = 0;
    while maxnum > E(j)
        y = U*y;
        y = -Forsub([LpD,y]) + c_gs;
        T_gs = T_gs + 1;
        maxnum = max(abs(A*y - b));
    end
    outT_gs = [outT_gs, T_gs];
    outE_gs = [outE_gs, maxnum];
end
out = [outT_j; outE_j; outT_gs; outE_gs]
save CP3_T1.dat out -ascii

%%
%

clear all; close all;
x0 = [ .9;    % S
       .09;   % I
       .01 ]; % R
M1 = [1-1/200,        0,   1/10000;
        1/200, 1-1/1000,         0;
            0,   1/1000, 1-1/10000];
M2 = [1-1/200-2/1000,        0,   1/10000;
               1/200, 1-1/1000,         0;
             +2/1000,   1/1000, 1-1/10000];
D0 = 0;
D1 = 0;
x1 = x0;
x2 = x0;
x3 = x0;
x4 = x0;
while x1(2, 1) < 0.5 * 1
    x1 = M1 * x1;
    D0 = D0 + 1;
end
for i = 1: 99999
    x3 = M1 * x3;
end
while x2(2, 1) < 0.5 * 1
    x2 = M2 * x2;
    D1 = D1 + 1;
end
for i = 1: 99999
    x4 = M2 * x4;
end
out = [ D0, D1; x3(2,1), x4(2,1)]
save CP3_T2.dat out -ascii

%%
%

clear all; close all;
M = [];
for i = 1 : 41
    M(1, i) = 1 / i * (-1)^(i + 1);
    M(i+1, i) = 1/i;
end
out = M;
save CP3_T3_1.dat out -ascii

A = zeros(41, 1);
A(1) = 1;
for j = 2 : 2 : 40
    A(j + 1) = 1 / factorial(j / 2) * (-1)^(j/2);
end
answer = M * A;
out = 0;
for k = 1 : 42
    out = out + answer(k);
end
out
save CP3_T3_2.dat out -ascii