%%
%

clear all; close all;
r = RandStream('mt19937ar','Seed',1234);
A = r.randn(10,6);
b = ones(10,1);
result = [];
Q = eye(10);
R = A;

for i = 1 : 6
    w = R(i:end,i);
    w(1) = w(1) + sign(w(1))*norm(w);
    w = w/norm(w);
    R(i:end,i:end) = R(i:end,i:end) - 2*w*(w'*R(i:end,i:end));
    Q(:,i:end) = Q(:,i:end) - 2*(Q(:,i:end)*w)*w';
    result = [result; R];
end
result;
save CP4_T1.dat result -ascii

y = (A'*A)^(-1)*A'*b;
min = norm(A*y - b);
save CP4_min.dat min -ascii
%%
%

clear all; close all;
r = RandStream('mt19937ar','Seed',1234);
A = r.randn(10,6);
b = r.randn(10,1);
Q = eye(size(A, 1));
R = [A,b];
for i = 1 : 6
    w = R(i:end,i);
    w(1) = w(1) + sign(w(1))*norm(w);
    w = w/norm(w);
    R(i:end,i:end) = R(i:end,i:end) - 2*w*(w'*R(i:end,i:end));
    Q(:,i:end) = Q(:,i:end) - 2*(Q(:,i:end)*w)*w';
end

x = Backsub(R(1:6, :));

save CP4_T2.dat x -ascii

%%
%

clear all; close all;
r = RandStream('mt19937ar','Seed',1234);
A = r.randn(30,10);
b = r.randn(30,1);
out = [];

y = zeros(10, 1);
c = A'*b;
epsilon = 1e-8;
for i = 1 : 100
    res = A'*(A*y)-c;
    v = A*res;
    step = (res'*res)/(v'*v)*res;
    y = y - step;
    out = [out, max(abs(step))];
    if max(abs(step)) < epsilon
        break;
    end
end
save CP4_T3.dat out -ascii

%%
%

r = RandStream('mt19937ar','Seed',1234);
A = r.randn(6,10);
b = r.randn(6,1);

% A = [10^(-16) * eye(10); A];
% b = [zeros(10, 1); b];
[n, m] = size(A);
Ah = [10^(-8)*eye(m); A];
bh = [zeros(m, 1); b];
Q = eye(size(Ah, 1));
R = [Ah,bh];
for i = 1 : 10
    w = R(i:end,i);
    w(1) = w(1) + sign(w(1))*norm(w);
    w = w/norm(w);
    R(i:end,i:end) = R(i:end,i:end) - 2*w*(w'*R(i:end,i:end))
%     Q(:,i:end) = Q(:,i:end) - 2*(Q(:,i:end)*w)*w';
end

x = Backsub(R(1:10, 1:11));

save CP4_T4.dat x -ascii

%%
%

function x = Backsub(U)
    n = size(U); n = n(1); % get the number of rows of U
    x = U(:,n+1);
    if U(n,n) == 0
        disp('Method failed: singular matrix');
        x = Inf; % return infinity if there is no solution
    else
        x(n) = U(n,n+1)/U(n,n);
        for k = 1:n-1
            i = n-k;
            if U(i,i) == 0
                disp('Method failed: singular matrix');
                x = Inf;
                break; % return infinity if there is no solution
            else
               SUM = 0;  % compute the sum as j varies from i+1 to n
               for j = i+1:n
                   SUM = SUM + U(i,j)*x(j);
               end
               x(i) = U(i,n+1)-SUM;
               x(i) = x(i)/U(i,i);
            end
            
        end
    end     
end